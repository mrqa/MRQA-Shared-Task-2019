#! /bin/bash

set -e

OUTPUT=$1

mkdir -p $OUTPUT

wget http://participants-area.bioasq.org/MRQA2019/ -O $OUTPUT/BioASQ.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/TextbookQA.jsonl.gz -O $OUTPUT/TextbookQA.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/RelationExtraction.jsonl.gz -O $OUTPUT/RelationExtraction.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/DROP.jsonl.gz -O $OUTPUT/DROP.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/DuoRC.ParaphraseRC.jsonl.gz -O $OUTPUT/DuoRC.jsonl.gz
wget https://s3.us-east-2.amazonaws.com/mrqa/release/v2/dev/RACE.jsonl.gz -O $OUTPUT/RACE.jsonl.gz
