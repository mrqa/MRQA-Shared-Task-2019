#! /bin/bash

set -e

OUTPUT=$1

mkdir -p $OUTPUT

wget https://s3.us-east-2.amazonaws.com/mrqa/release/dev/TextbookQA.jsonl.gz -O $OUTPUT/TextbookQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/dev/RelationExtraction.jsonl.gz -O $OUTPUT/RelationExtraction.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/dev/DROP.jsonl.gz -O $OUTPUT/DROP.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/dev/DuoRC.ParaphraseRC.jsonl.gz -O $OUTPUT/DuoRC.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/dev/RACE.jsonl.gz -O $OUTPUT/RACE.jsonl.gz
