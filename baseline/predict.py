import argparse
import mrqa_allennlp
from allennlp.models.archival import load_archive
from allennlp.predictors import Predictor
from allennlp.common.file_utils import cached_path
import numpy as np
import gzip
import json
from allennlp.common.tqdm import Tqdm

if __name__ == "__main__":
    parse = argparse.ArgumentParser("")
    parse.add_argument("model")
    parse.add_argument("dataset")
    parse.add_argument("output_file")
    parse.add_argument("--cuda_device", type=int, default=-1)
    args = parse.parse_args()

    file_path = cached_path(args.model)
    archive = load_archive(file_path, cuda_device=args.cuda_device)
    predictor = Predictor.from_archive(archive, 'mrqa_predictor')
    predictor._dataset_reader._is_training = False

    all_predictions = {}
    contexts = []
    single_file_path_cached = cached_path(args.dataset)
    with gzip.open(single_file_path_cached, 'rb') as myzip:
        for example in myzip:
            context = json.loads(example)
            if 'header' in context:
                continue
            contexts.append(context)

    for context in Tqdm.tqdm(contexts,total = len(contexts)):
        all_predictions.update(predictor.predict_json(context))

    with open(args.output_file,'w') as f:
        json.dump(all_predictions,f)



