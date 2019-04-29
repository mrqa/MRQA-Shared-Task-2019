#! /bin/bash

set -e

OUTPUT=$1

mkdir -p $OUTPUT

wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz -O $OUTPUT/SQuAD.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/NewsQA.jsonl.gz -O $OUTPUT/NewsQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/TriviaQA-unfilt.jsonl.gz -O $OUTPUT/TriviaQA-unfilt.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/TriviaQA-web.jsonl.gz -O $OUTPUT/TriviaQA-web.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SearchQA.jsonl.gz -O $OUTPUT/SearchQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/HotpotQA.jsonl.gz -O $OUTPUT/HotpotQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/data/dev/NaturalQuestionsShort.jsonl.gz -O $OUTPUT/NaturalQuestions.jsonl.gz
