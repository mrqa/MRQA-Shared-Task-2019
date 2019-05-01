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

The AllenNLP train command is used for training. The training and validation files should be provided as an override to the base config. 

 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s [SERIALIZATION_DIR] -o "{'train_data_path': 's3://mrqa/data/train/[TRAINING_SET1],s3://mrqa/data/train/[TRAINING_SET2(optional)]', 'validation_data_path': 's3://mrqa/data/dev/[DEV_SET1],s3://mrqa/data/dev/[DEV_SET2(optional)]', 'trainer': {'cuda_device': [CUDE DEVICEID or -1 for CPU], 'num_epochs': [NUM_OF_EPOCHES, usually 2], 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': [T_TOTAL = #TRAINING_EXAMPLES / BATCH_SIZE(default=6) * NUM_OF_EPOCHES}}}" --include-package mrqa_allennlp`.
 
 ### Example - BERTBase
 
 single dataset training:
 
 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s Models/SQuAD -o "{'train_data_path': 's3://mrqa/data/train/SQuAD.jsonl.gz', 'validation_data_path': 's3://mrqa/data/dev/SQuAD.jsonl.gz', 'trainer': {'cuda_device': -1, 'num_epochs': 2, 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': 29000}}}" --include-package mrqa_allennlp `

 Training on all training sets (multi-task), this is our baseline training for BERTBase:
 
 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s ../Models/MultiTrain -o "{'dataset_reader': {'sample_size': 75000}, 'validation_dataset_reader': {'sample_size': 1000}, 'train_data_path': 's3://mrqa/data/train/SQuAD.jsonl.gz,s3://mrqa/data/train/NewsQA.jsonl.gz,s3://mrqa/data/train/HotpotQA.jsonl.gz,s3://mrqa/data/train/SearchQA.jsonl.gz,s3://mrqa/data/train/TriviaQA-web.jsonl.gz,s3://mrqa/data/train/NaturalQuestionsShort.jsonl.gz', 'validation_data_path': 's3://mrqa/data/dev/SQuAD.jsonl.gz,s3://mrqa/data/dev/NewsQA.jsonl.gz,s3://mrqa/data/dev/HotpotQA.jsonl.gz,s3://mrqa/data/dev/SearchQA.jsonl.gz,s3://mrqa/data/dev/TriviaQA-web.jsonl.gz,s3://mrqa/data/dev/NaturalQuestionsShort.jsonl.gz', 'trainer': {'cuda_device': [2,3,4,5], 'num_epochs': '2', 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': '120000'}}}" --include-package mrqa_allennlp`
 

 ### BERTLarge
  Training on all training sets (multi-task), this is our baseline training for BERTLarge:
 
  `python -m allennlp.run train s3://multiqa/config/MRQA_BERTLarge.json -s Models/MultiTrain -o "{'dataset_reader': {'sample_size': 75000}, 'validation_dataset_reader': {'sample_size': 1000}, 'train_data_path': 's3://mrqa/data/train/SQuAD.jsonl.gz,s3://mrqa/data/train/NewsQA.jsonl.gz,s3://mrqa/data/train/HotpotQA.jsonl.gz,s3://mrqa/data/train/SearchQA.jsonl.gz,s3://mrqa/data/train/TriviaQA-web.jsonl.gz,s3://mrqa/data/train/NaturalQuestionsShort.jsonl.gz', 'validation_data_path': 's3://mrqa/data/dev/SQuAD.jsonl.gz,s3://mrqa/data/dev/NewsQA.jsonl.gz,s3://mrqa/data/dev/HotpotQA.jsonl.gz,s3://mrqa/data/dev/SearchQA.jsonl.gz,s3://mrqa/data/dev/TriviaQA-web.jsonl.gz,s3://mrqa/data/dev/NaturalQuestionsShort.jsonl.gz', 'trainer': {'cuda_device': [2,3,4,5], 'num_epochs': '2', 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': '145000'}}}" --include-package mrqa_allennlp`
 

 
 
## Making predictions
 
 `python predict.py model dataset outputfile `
 
 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
 With GPU device:
 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json --cuda_device 0`
 
 
### Evaluate 
 `python ../mrqa_official_eval.py https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
## Server mode
To query a single JSON object in the MRQA format, start a server:

    ```
    python serve.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz
    ```

To interact with the server, send a POST request:

    ```
    curl -X POST -H "Content-Type: application/json" -d @NewsQA_single_sample.json localhost:8888
    ```

You should get the response, `{"f7b2f89be1724a9c86cbcc347b0c4425":"Harrison Ford"}`.
