# 2019 Shared Task on Extractive Question Answering

## Overview

The 2019 MRQA Shared Task focuses on extractive question answering. Given a question and context passage, systems must find the word or phrase in the document that best answers the question. While this format is somewhat restrictive, it allows us to leverage many existing datasets, and its simplicity helps us focus on out-of-domain generalization, instead of other important but orthogonal challenges.

We release an official training dataset containing examples from existing extractive QA datasets, and evaluate submitted models on ten hidden test datasets. Both train and test datasets have the same format described above, but may differ in some of the following ways:

- **Passage distribution:** Test examples may involve passages from different sources (e.g., science, news, novels, medical abstracts, etc) with pronounced syntactic and lexical differences.
- **Question distribution:** Test examples may emphasize different styles of questions (e.g., entity-centric, relational, other tasks reformulated as QA, etc) which may come from different sources (e.g., crowdworkers, domain experts, exam writers, etc.)
- **Joint distribution:** Test examples may vary according to the relationship of the question to the passage (e.g., collected independent vs. dependent of evidence, multi-hop, etc)

Each participant will submit a single QA system trained on the provided training data. We will then privately evaluate each system on the hidden test data.

This repository contains resources for accessing the official training and development data.

## Training Data

The following datasets have been selected for training:

## Dataset Format

All of the datasets for this task have been adapted to follow a unified format. They are stored a compressed JSONL files (`.jsonl.gz`).

The general format is:

```
{
  "header": {
    "dataset": <dataset name>,
    "mrqa_split": <train|dev|test>,
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
          "text": <normalized answer string>,
          "char_spans": [[<start_1, end_1>], ..., [<start_n, end_n>]],
          "token_spans": [[<start_1, end_1>], ..., [<start_n, end_n>]],
        },
        ...
      ],
      "answers": [<raw_text_1>, ..., <raw_text_m>],
      "is_impossible": <has_no_answer>
    },
    ...
  ]
}
```

### Fields

- **context:** This is the raw text of the supporting passage. Three special token types have been inserted: `[TLE]` precedes document titles, `[DOC]` denotes document breaks, and `[PAR]` denotes paragraph breaks. The maximum length of the context is 800 tokens.
- **context_tokens:** A tokenized version of the supporting passage, using [spaCy](spacy.io). Each token is a tuple of the token string and token character offset. The maximum number of tokens is 800.
- **qas:** A list of questions for the given context.
- **qid:** A unique identifier for the question. The `qid` is unique across all datasets.
- **question:** The raw text of the question.
- **question_tokens:** A tokenized version of the question. The tokenizer and token format is the same as for the context.
- **detected_answers:** A list of answer spans for the given question that index into the context. For some datasets these spans have been automatically detected using searching heuristics. For any given answer, it may appear multiple times in the text --- each of these occurrences is given. For example, if `42` is the answer, the context, "The answer is <42>. <42> is the answer.", has two occurences. During training, an acceptable stategy might be to pick the first occurrence of the first answer.
  - **text:** The raw text of the detected answer.
  - **char_spans:** Inclusive `[start, end]` character spans (indexing into the raw context).
  - **token_spans:** Inclusive `[start, end]` token spans (indexing into the tokenized context).
- **answers:** All accepted answer to the question, whether or not there is an exact match in the given context.


## Visualization

To view examples in the terminal run:
```
python utils/visualize.py example.jsonl.gz
```

You can also pass a URL instead of a local path. For example:

```
python utils/visualize.py https://s3.us-east-2.amazonaws.com/mrqa/data/test/ATIS.train.jsonl.gz
```

All of the dataset names and their AWS paths are in `manifest.json`.  By default `visualize.py` will select `50` random examples (set with `--samples N`). If you hit `cntrl-C` it will quick and print the progress up until that point.
