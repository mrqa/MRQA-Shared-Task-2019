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

### Quick Links

- [Datasets](#datasets)
- [Download](#download-scripts)
- [Format](#dataset-format)
- [Visualize](#visualization)
- [Evaluate](#evaluation)
- [Baseline](#baseline-model)

## Datasets

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
| [SQuAD](https://arxiv.org/abs/1606.05250) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/SQuAD.jsonl.gz) | 67afd110c0ad9860c4e88f16a44cd44c | 86,588 |
| [NewsQA](https://arxiv.org/abs/1611.09830) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/NewsQA.jsonl.gz) | d8288b5de5bd10fb42ce5291ef0f7fbe | 74,160 |
| [TriviaQA](https://arxiv.org/abs/1705.03551) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/TriviaQA-web.jsonl.gz) | 1d198c0cd60e4d91130e2a2545eb9122 | 61,688 |
| [SearchQA](https://arxiv.org/abs/1704.05179) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/SearchQA.jsonl.gz) | fa9c8c6b2f24e4f410cba81ef63ea284 | 117,384 |
| [HotpotQA](https://arxiv.org/abs/1809.09600) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/HotpotQA.jsonl.gz) | 53e65212b46c74a6ee95e83817443db1 | 72,912 |
| [NaturalQuestions](https://ai.google/research/pubs/pub47761) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/train/NaturalQuestionsShort.jsonl.gz) | f12d2ce98ba0065a79226b9fa22d936a | 104,071 |

### Development Data

#### In-Domain

| Dataset | Download | MD5SUM | Examples |
| :-----: | :-------:| :----: | :------: |
| [SQuAD](https://arxiv.org/abs/1606.05250) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/SQuAD.jsonl.gz) | be0d95e28b470254b3574aeada84a79d | 10,507 |
| [NewsQA](https://arxiv.org/abs/1611.09830) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/NewsQA.jsonl.gz) | aa9878b7469ad5b5c0f0738636cdb5bd | 4,212 |
| [TriviaQA](https://arxiv.org/abs/1705.03551) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/TriviaQA-web.jsonl.gz) | fdfac306651dd74372f0edcff357ec80 | 7,785|
| [SearchQA](https://arxiv.org/abs/1704.05179) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/SearchQA.jsonl.gz) | fa087f2cc134f9c316f1d93c40827615 | 16,980 |
| [HotpotQA](https://arxiv.org/abs/1809.09600) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/HotpotQA.jsonl.gz) | d0adef52100cbbf93090ba6c06b83b2b | 5,901 |
| [NaturalQuestions](https://ai.google/research/pubs/pub47761) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/NaturalQuestionsShort.jsonl.gz) | a017834fddfe9df888b7f6cd5bbfba2e | 12,836 |

**Note:** This in-domain data may be used for helping develop models. The final testing, however, will only contain out-of-domain data.

#### Out-of-Domain

| Dataset | Download | MD5SUM | Examples |
| :-----: | :-------:| :----: | :------: |
| [BioASQ](http://bioasq.org/) | TBA | 00ac07599c80c1ac36256f0a2f4bda48 | 1,504 |
| [DROP](https://arxiv.org/abs/1903.00161) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/DROP.jsonl.gz) | 0b509e2bebdba16d81f1d3c4f9bedf7c | 1,503 |
| [DuoRC](https://arxiv.org/abs/1804.07927) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/DuoRC.ParaphraseRC.jsonl.gz) | dcb351275bb7695a54270ca4b59b85c8 | 1,501 |
| [RACE](https://arxiv.org/abs/1704.04683) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/RACE.jsonl.gz) | 6cf376f0ab4217e147a2ff4603972e37 | 674 |
| [RelationExtraction](https://arxiv.org/abs/1706.04115) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/RelationExtraction.jsonl.gz) | 20e0fc79f26d13eaac68e62c77980223 | 2,948|
| [TextbookQA](http://ai2-website.s3.amazonaws.com/publications/CVPR17_TQA.pdf) | [Link](https://s3.us-east-2.amazonaws.com/mrqa/release/dev/TextbookQA.jsonl.gz) | 3319b8aab7aea550e2392f9b95bbf415 | 1,503 |

*The BioASQ split will be released through the BioASQ website. Details pending.*

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
./download_out_of_domain_domain_dev.sh path/to/store/downloaded/directory
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

Answers are evaluated using exact match and token-level F1 metrics. The `mrqa_official_eval.py` script is used to evaluate predictions on a given dataset:

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

An implementation of a simple multi-task BERT-based baseline model is available in the `baseline` directory. 

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

Submission will be handled through the [Codalab](https://worksheets.codalab.org/) platform.
Instructions will be released soon.
We will ask participants to submit two components:

1. A command that makes predictions given a `.jsonl.gz` file in our standard format;
2. A command that starts a local server that accepts POST requests of single JSON objects in our standard format, and returns a JSON prediction object.

The `baseline` directory includes example implementations of both components, in `predict.py` and `serve.py`, respectively.
The server will be used to create interactive demos for all submitted models.
