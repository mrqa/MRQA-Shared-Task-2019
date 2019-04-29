#! /bin/bash

set -e

OUTPUT=$1

mkdir -p $OUTPUT

wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/SQuAD.jsonl.gz -O $OUTPUT/SQuAD.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/NewsQA.jsonl.gz -O $OUTPUT/NewsQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/TriviaQA-unfilt.jsonl.gz -O $OUTPUT/TriviaQA-unfilt.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/TriviaQA-web.jsonl.gz -O $OUTPUT/TriviaQA-web.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/SearchQA.jsonl.gz -O $OUTPUT/SearchQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/HotpotQA.jsonl.gz -O $OUTPUT/HotpotQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/train/NaturalQuestionsShort.jsonl.gz -O $OUTPUT/NaturalQuestions.jsonl.gz
