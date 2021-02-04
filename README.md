# MRQA 2019 Shared Task on Generalization

## Overview

The MRQA 2019 Shared Task focuses on generalization in question answering. An effective question answering system should do more than merely interpolate from the training set to answer test examples drawn from the same distribution: it should also be able to extrapolate to out-of-distribution examples — a significantly harder challenge. 

The format of the task is extractive question answering. Given a question and context passage, systems must find the word or phrase in the document that best answers the question. While this format is somewhat restrictive, it allows us to leverage many existing datasets, and its simplicity helps us focus on out-of-domain generalization, instead of other important but orthogonal challenges.

We release an official training dataset containing examples from existing extractive QA datasets, and evaluate submitted models on ten hidden test datasets. Both train and test datasets have the same format described above, but may differ in some of the following ways:

- **Passage distribution:** Test examples may involve passages from different sources (e.g., science, news, novels, medical abstracts, etc) with pronounced syntactic and lexical differences.
- **Question distribution:** Test examples may emphasize different styles of questions (e.g., entity-centric, relational, other tasks reformulated as QA, etc) which may come from different sources (e.g., crowdworkers, domain experts, exam writers, etc.)
- **Joint distribution:** Test examples may vary according to the relationship of the question to the passage (e.g., collected independent vs. dependent of evidence, multi-hop, etc)

Each participant will submit a single QA system trained on the provided training data. We will then privately evaluate each system on the hidden test data.

This repository contains resources for accessing the official training and development data.
If you are interested in participating, please fill out [this form](https://forms.gle/TZCeK9NwAyGozxc57)!
We will e-mail participants who sign up of any important announcements regarding the shared task.

### Quick Links

- [Datasets](#datasets)
- [Download](#download-scripts)
- [Format](#dataset-format)
- [Visualize](#visualization)
- [Evaluate](#evaluation)
- [Baseline](#baseline-model)
- [Submission](#submission)

## Datasets

**Updated 7/12/2019 to correct for minor exact-match discrepancies**
*(See [#11](https://github.com/mrqa/MRQA-Shared-Task-2019/issues/11) for details.)*

**Updated 6/13/2019 to correct for duplicate context in HotpotQA**
*(See [#7](https://github.com/mrqa/MRQA-Shared-Task-2019/issues/7) for details.)*

**Updated 5/29/2019 to correct for truncated `detected_answers` field**
*(See [#5](https://github.com/mrqa/MRQA-Shared-Task-2019/issues/5) for details.)*

We have adapted several existing datasets from their original formats and settings to conform to our unified extractive setting. Most notably:

- We provide only a single, length-limited context.
- There are no unanswerable or non-span answer questions.
- All questions have at least one accepted answer that is found exactly in the context.

A span is judged to be an exact match if it matches the answer string after performing normalization consistent with the [SQuAD](https://stanford-qa.com) dataset. Specifically:

- The text is uncased.
- All punctuation is stripped.
- All articles `{a, an, the}` are removed.
- All consecutive whitespace markers are compressed to just a single normal space `' '`.

### Training Data

| Dataset | Download | MD5SUM | Examples |
| :-----: | :-------:| :----: | :------: |
| [SQuAD](https://arxiv.org/abs/1606.05250) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/SQuAD.jsonl.gz) | efd6a551d2697c20a694e933210489f8 | 86,588 |
| [NewsQA](https://arxiv.org/abs/1611.09830) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/NewsQA.jsonl.gz) | 182f4e977b849cb1dbfb796030b91444 | 74,160 |
| [TriviaQA](https://arxiv.org/abs/1705.03551) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/TriviaQA-web.jsonl.gz) | e18f586152612a9358c22f5536bfd32a | 61,688 |
| [SearchQA](https://arxiv.org/abs/1704.05179) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/SearchQA.jsonl.gz) | 612245315e6e7c4d8446e5fcc3dc1086 | 117,384 |
| [HotpotQA](https://arxiv.org/abs/1809.09600) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/HotpotQA.jsonl.gz) | d212c7b3fc949bd0dc47d124e8c34907 | 72,928 |
| [NaturalQuestions](https://ai.google/research/pubs/pub47761) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/train/NaturalQuestionsShort.jsonl.gz) | e27d27bf7c49eb5ead43cef3f41de6be | 104,071 |

### Development Data

#### In-Domain

| Dataset | Download | MD5SUM | Examples |
| :-----: | :-------:| :----: | :------: |
| [SQuAD](https://arxiv.org/abs/1606.05250) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/SQuAD.jsonl.gz) | 05f3f16c5c31ba8e46ff5fa80647ac46 | 10,507 |
| [NewsQA](https://arxiv.org/abs/1611.09830) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/NewsQA.jsonl.gz) | 5c188c92a84ddffe2ab590ac7598bde2 | 4,212 |
| [TriviaQA](https://arxiv.org/abs/1705.03551) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/TriviaQA-web.jsonl.gz) | 5c9fdc633dfe196f1b428c81205fd82f | 7,785|
| [SearchQA](https://arxiv.org/abs/1704.05179) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/SearchQA.jsonl.gz) | 9217ad3f6925c384702f2a4e6d520c38 | 16,980 |
| [HotpotQA](https://arxiv.org/abs/1809.09600) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/HotpotQA.jsonl.gz) | 125a96846c830381a8acff110ff6bd84 | 5,904 |
| [NaturalQuestions](https://ai.google/research/pubs/pub47761) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/NaturalQuestionsShort.jsonl.gz) | c0347eebbca02d10d1b07b9a64efe61d | 12,836 |

**Note:** This in-domain data may be used for helping develop models. The final testing, however, will only contain out-of-domain data.

#### Out-of-Domain

| Dataset | Download | MD5SUM | Examples |
| :-----: | :-------:| :----: | :------: |
| [BioASQ](http://bioasq.org/) | [Link](http://participants-area.bioasq.org/MRQA2019/) | 70752a39beb826a022ab21353cb66e54 | 1,504 |
| [DROP](https://arxiv.org/abs/1903.00161) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/DROP.jsonl.gz) | 070eb2ac92d2b2fc1b99abeda97ac37a | 1,503 |
| [DuoRC](https://arxiv.org/abs/1804.07927) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/DuoRC.ParaphraseRC.jsonl.gz) |b325c0ad2fa10e699136561ee70c5ddd | 1,501 |
| [RACE](https://arxiv.org/abs/1704.04683) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/RACE.jsonl.gz) | ba8063647955bbb3ba63e9b17d82e815 | 674 |
| [RelationExtraction](https://arxiv.org/abs/1706.04115) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/RelationExtraction.jsonl.gz) | 266be75954fcb31b9dbfa9be7a61f088 | 2,948|
| [TextbookQA](http://ai2-website.s3.amazonaws.com/publications/CVPR17_TQA.pdf) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/TextbookQA.jsonl.gz) | 8b52d21381d841f8985839ec41a6c7f7 | 1,503 |

**Note:** As previously mentioned, the out-of-domain dataset have been modified from their original settings to fit the unified MRQA Shared Task paradigm (see [MRQA Format](#mrqa-format)). Once again, at a high level, the following two major modifications have been made:

1. All QA-context pairs are extractive. That is, the answer is selected from the context and not via, e.g., multiple-choice.
2. All contexts are capped at a maximum of `800` tokens. As a result, for longer contexts like Wikipedia articles, we only consider examples where the answer appears in the first `800` tokens.

As a result, some splits are harder than the original datasets (e.g., removal of multiple-choice in RACE), while some are easier (e.g., restricted context length in NaturalQuestions --- we use the short answer selection). Thus one should expect different performance ranges if comparing to previous work on these datasets.

### Auxiliary Data

For additional sources of training data, we are whitelisting some non-QA datasets that may be helpful for multi-task learning or pretraining. If you have any other dataset in mind , please raise an issue or send us an email at mrforqa@gmail.com .

**Whitelist**:
- SNLI
- MultiNLI

## Download Scripts

We have provided a convenience script to download all of the training and development data (that is released).

Please run:
```
./download_train.sh path/to/store/downloaded/directory
```

To download the development data of the training datasets (in-domain), run:
```
./download_in_domain_dev.sh path/to/store/downloaded/directory
```

To download the out-of-domain development data, run:
```
./download_out_of_domain_dev.sh path/to/store/downloaded/directory
```

## MRQA Format

All of the datasets for this task have been adapted to follow a unified format. They are stored as compressed [JSONL](http://jsonlines.org/) files (with file extension `.jsonl.gz`).

The general format is:

```
{
  "header": {
    "dataset": <dataset name>,
    "split": <train|dev|test>,
  }
}
...
{
  "context": <context text>,
  "context_tokens": [(token_1, offset_1), ..., (token_l, offset_l)],
  "qas": [
    {
      "qid": <uuid>,
      "question": <question text>,
      "question_tokens": [(token_1, offset_1), ..., (token_q, offset_q)],
      "detected_answers": [
        {
          "text": <answer text>,
          "char_spans": [[<start_1, end_1>], ..., [<start_n, end_n>]],
          "token_spans": [[<start_1, end_1>], ..., [<start_n, end_n>]],
        },
        ...
      ],
      "answers": [<answer_text_1>, ..., <answer_text_m>]
    },
    ...
  ]
}
```

Note that it is permissible to download the original datasets and use them as you wish. However, this is the format that the test data will be presented in.

### Fields

- **context:** This is the raw text of the supporting passage. Three special token types have been inserted: `[TLE]` precedes document titles, `[DOC]` denotes document breaks, and `[PAR]` denotes paragraph breaks. The maximum length of the context is 800 tokens.
- **context_tokens:** A tokenized version of the supporting passage, using [spaCy](spacy.io). Each token is a tuple of the token string and token character offset. The maximum number of tokens is 800.
- **qas:** A list of questions for the given context.
- **qid:** A unique identifier for the question. The `qid` is unique across all datasets.
- **question:** The raw text of the question.
- **question_tokens:** A tokenized version of the question. The tokenizer and token format is the same as for the context.
- **detected_answers:** A list of answer spans for the given question that index into the context. For some datasets these spans have been automatically detected using searching heuristics. The same answer may appear multiple times in the text --- each of these occurrences is recorded. For example, if `42` is the answer, the context `"The answer is 42. 42 is the answer."`, has two occurrences marked.
  - **text:** The raw text of the detected answer.
  - **char_spans:** Inclusive `[start, end]` character spans (indexing into the raw context).
  - **token_spans:** Inclusive `[start, end]` token spans (indexing into the tokenized context).
- **answers:** All accepted answer to the question, whether or not there is an exact match in the given context.


## Visualization

To view examples in the terminal please install `requirements.txt` (`pip install requirements.txt`) and then run:
```
python visualize.py path/or/url
```

The script argument may be either a URL or a local file path. For example:

```
python visualize.py https://s3.us-east-2.amazonaws.com/mrqa/release/train/SQuAD.jsonl.gz
```

## Evaluation

Answers are evaluated using exact match and token-level F1 metrics. The [mrqa_official_eval.py](mrqa_official_eval.py) script is used to evaluate predictions on a given dataset:

```
python mrqa_official_eval.py <url_or_filename> <predictions_file>
```

The predictions file must be a valid JSON file of `qid`, `answer` pairs:

```
{
  "qid_1": "answer span text 1",
  ...
  "qid_n": "answer span text N"
}
```

The final score for the MRQA shared task will be the macro-average across all test datasets.

## Baseline Model

An implementation of a simple multi-task BERT-based baseline model is available in the [baseline](baseline) directory. 

Below are our baseline results (I = in-domain, O = out-of-domain):

| Dataset | [Multi-Task BERT-Base](https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz) | [Multi-Task BERT-Large](https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6_large.tar.gz)|
| :----- | :-------------------:| :------------------: |
| (I) SQuAD | 78.5 / 86.7 | 80.3 / 88.4 |
| (I) HotpotQA | 59.8 / 76.6 | 62.4 / 79.0 |
| (I) TriviaQA Web | 65.6 / 71.6 | 68.2 / 74.7 |
| (I) NewsQA | 50.8 / 66.8 | 49.6 / 66.3 |
| (I) SearchQA | 69.5 / 76.7 | 71.8 / 79.0 |
| (I) NaturalQuestions | 65.4 / 77.4 | 67.9 / 79.8 |
| (O) DROP | 25.7 / 34.5 | 34.6 / 43.8 |
| (O) RACE | 30.4 / 41.4 | 31.3 / 42.5 |
| (O) BioASQ | 47.1 / 62.7 | 51.9 / 66.8 |
| (O) TextbookQA | 44.9 / 53.9 | 47.4 / 55.7 |
| (O) RelationExtraction | 72.6 / 83.8 | 72.7 / 85.2 |
| (O) DuoRC | 44.8 / 54.6 | 46.8 / 58.0 |
 

## Submission

Submission will be handled through the [Codalab](https://worksheets.codalab.org/) platform:
see [these instructions](https://worksheets.codalab.org/worksheets/0x926e37ac8b4941f793bf9b9758cc01be/).

Note that submissions should start a local server that accepts POST requests of single JSON objects in our standard format, and returns a JSON prediction object.
The official `predict_server.py` script (in this directory) will query this server to get predictions.
The `baseline` directory includes an example implementation in `serve.py`.
We have chosen this format so that we can create interactive demos for all submitted models.

## Results
Codalab results for all models submitted to the shared task are available in the `results` directory.
These files include the dev and test EM and F1 scores for every model and every dataset. 

## Citation

```
@inproceedings{fisch2019mrqa,
    title={{MRQA} 2019 Shared Task: Evaluating Generalization in Reading Comprehension},
    author={Adam Fisch and Alon Talmor and Robin Jia and Minjoon Seo and Eunsol Choi and Danqi Chen},
    booktitle={Proceedings of 2nd Machine Reading for Reading Comprehension (MRQA) Workshop at EMNLP},
    year={2019},
}
```
