## Setup

### Setting up a virtual environment

1.  Change your directory to this one:

    ```
    cd baseline
    ```

2.  Create a virtual environment with Python 3.6 or above:

    ```
    virtualenv venv --python=python3.7
    ```

3.  Activate the virtual environment.
    
    ```
    source venv/bin/activate (or source venv/bin/activate.csh)
    ```

4.  Install the required dependencies:

    ```
    pip3 install -r requirements.txt
    ```

### Data

The allennlp caching infra is used, so be sure to have enough disk space, and control the cache directory using `ALLENNLP_CACHE_ROOT` env variable.


## Training

 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s [SERIALIZATION_DIR] -o "{'train_data_path': 's3://mrqa/data/train/[TRAINING_SET1],s3://mrqa/data/train/[TRAINING_SET2(optional)]', 'validation_data_path': 's3://mrqa/data/dev/[DEV_SET1],s3://mrqa/data/dev/[DEV_SET2(optional)]', 'trainer': {'cuda_device': [CUDE DEVICEID or -1 for CPU], 'num_epochs': [NUM_OF_EPOCHES, usually 2], 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': [T_TOTAL = #TRAINING_EXAMPLES / BATCH_SIZE(default=6) * NUM_OF_EPOCHES}}}"  --include-package mrqa_iterator --include-package BERT_QA --include-package mrqa_reader`.
 
 example (single dataset):
 
 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s Models/SQuAD -o "{'train_data_path': 's3://mrqa/data/train/SQuAD.jsonl.gz', 'validation_data_path': 's3://mrqa/data/dev/SQuAD.jsonl.gz', 'trainer': {'cuda_device': -1, 'num_epochs': 2, 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': 29000}}}"  --include-package mrqa_iterator --include-package BERT_QA --include-package mrqa_reader `

 multiple training sets:
 
 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s Models/MultiTrain -o "{'dataset_reader': {'sample_size': 75000}, 'validation_dataset_reader': {'sample_size': 1000}, 'train_data_path': 's3://mrqa/data/train/SQuAD.jsonl.gz,s3://mrqa/data/train/NewsQA.jsonl.gz,s3://mrqa/data/train/HotpotQA.jsonl.gz,s3://mrqa/data/train/SearchQA.jsonl.gz,s3://mrqa/data/train/TriviaQA-web.jsonl.gz', 'validation_data_path': 's3://mrqa/data/dev/SQuAD.jsonl.gz,s3://mrqa/data/dev/NewsQA.jsonl.gz,s3://mrqa/data/dev/HotpotQA.jsonl.gz,s3://mrqa/data/dev/SearchQA.jsonl.gz,s3://mrqa/data/dev/TriviaQA-web.jsonl.gz', 'trainer': {'cuda_device': -1, 'num_epochs': '2', 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': '120000'}}}" --include-package mrqa_iterator --include-package BERT_QA --include-package mrqa_reader`
 
 
 ## Making predictions
 
 `python predict.py model dataset outputfile `
 
 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
 With GPU device:
 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json --cuda_device 0`
 
 
 ### Evaluate 
 `python ../mrqa_official_eval.py https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
 
 ## Results
 
Results are reported as EM/F1. I = in-domain, O = out-of-domain.

| Dataset | [Multi-Task BERT-Base](https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz) | [Multi-Task BERT-Large](https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6_large.tar.gz)|
| -----: | :-------------------:| :------------------: |
| (I) SQuAD | 78.5 / 86.7 | 80.3 / 88.4 |
| (I) HotpotQA | 59.8 / 76.6 | 62.4 / 79.0 |
| (I) TriviaQA Web | 65.6 / 71.6 | 68.2 / 74.7 |
| (I) NewsQA | 50.8 / 66.8 | 49.6 / 66.3 |
| (I) SearchQA | 69.5 / 76.7 | 71.8 / 79.0 |
| (I) NaturalQuestions | 65.4 / 77.4 | 67.9 / 79.8 |
| (O) Drop | 25.7 / 34.5 | 34.6 / 43.8 |
| (O) RACE | 30.4 / 41.4 | 31.3 / 42.5 |
| (O) BioASQ | 47.1 / 62.7 | 51.9 / 66.8 |
| (O) TextbookQA | 44.9 / 53.9 | 47.4 / 55.7 |
| (O) RelationExtraction | 72.6 / 83.8 | 72.7 / 85.2 |
| (O) DuoRC | 44.8 / 54.6 | 46.8 / 58.0 |
 



