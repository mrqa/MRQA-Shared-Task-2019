import json
from tqdm import tqdm
import argparse


def main(config):
    output = {}
    with open(config.file, "r") as f:
        header = f.readline()
        print("Processing the file:", header)
        output_file = f'{header["header"]["dataset"]}-{header["header"]["split"]}.json'
        print("Output will be stored in: ", output_file)
        if config.dry_run:
            return None
        n_qa = 0
        output["version"] = "1.1" # because there are no unanswerble questions
        output["data"] = [{"paragraphs": []}]
        lines = f.readlines()
        for line in tqdm(lines):
            line = json.loads(line)
            paragraph = {}
            paragraph["context"] = line["context"]
            paragraph["qas"] = []
            for qa in line["qas"]:
                qa["id"] = qa["qid"]
                del qa["qid"]
                del qa["question_tokens"]
                answers = []
                for a in line["detected_answers"]:
                    answers.append({"text": a["text"], "answer_start": a["char_spans"][0][0]})
                qa["answers"] = answers
                paragraph["qas"].append(qa)
                n_qa += 1
            output["data"][0]["paragraphs"].append(paragraph)

    with open(output_file, 'w') as f:
        json.dump(output, f, indent=4)
    print("File is saved in:", output_file)
    print("The total number of QA pairs is:", n_qa)
    return None


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('--file', type=str, default='')
    parser.add_argument('--dry_run', action='store_true', default=False)
    args = parser.parse_args()
    main(args)
