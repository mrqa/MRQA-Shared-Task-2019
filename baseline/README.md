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

 `python -m allennlp.run train https://multiqa.s3.amazonaws.com/config/MRQA_BERTbase.json -s [SERIALIZATION_DIR] -o "{'train_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/train/[TRAINING_SET1],https://mrqa.s3.us-east-2.amazonaws.com/data/train/[TRAINING_SET2(optional)]', 'validation_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/dev/[DEV_SET1],https://mrqa.s3.us-east-2.amazonaws.com/data/dev/[DEV_SET2(optional)]', 'trainer': {'cuda_device': [CUDE DEVICEID or -1 for CPU], 'num_epochs': [NUM_OF_EPOCHES, usually 2], 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': [T_TOTAL = #TRAINING_EXAMPLES / BATCH_SIZE(default=6) * NUM_OF_EPOCHES}}}" --include-package mrqa_allennlp`.
 
 ### Example - BERTBase
 
 single dataset training:
 
 `python -m allennlp.run train https://multiqa.s3.amazonaws.com/config/MRQA_BERTbase.json -s Models/SQuAD -o "{'train_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/train/SQuAD.jsonl.gz', 'validation_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/dev/SQuAD.jsonl.gz', 'trainer': {'cuda_device': -1, 'num_epochs': 2, 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': 29000}}}" --include-package mrqa_allennlp `

 Training on all training sets (multi-task), this is our baseline training for BERTBase:
 
 `python -m allennlp.run train s3://multiqa/config/MRQA_BERTbase.json -s ../Models/MultiTrain -o "{'dataset_reader': {'sample_size': 75000}, 'validation_dataset_reader': {'sample_size': 1000}, 'train_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/train/SQuAD.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/NewsQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/HotpotQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/SearchQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/TriviaQA-web.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/NaturalQuestionsShort.jsonl.gz', 'validation_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/dev/SQuAD.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/NewsQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/HotpotQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/SearchQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/TriviaQA-web.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/NaturalQuestionsShort.jsonl.gz', 'trainer': {'cuda_device': [2,3,4,5], 'num_epochs': '2', 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': '120000'}}}" --include-package mrqa_allennlp`
 

 ### BERTLarge
  
  Training on all training sets (multi-task), this is our baseline training for BERTLarge.
  
  1. Multi-task training datasets are limited to 75,000 examples per dataset.
  2. 1,000 examples are sampled for each development set.
  3. 'train_data_path'/'validation_data_path: 6 pre-processed training datasets are specified for the mix.
  4. 'cuda_device': [0,1,2,3]: an example of using 4 GPUs for BERTLarge with AllenNLP.  
  5. 't_total': learning rate scheduler parameter for BERT model.  
 
  `python -m allennlp.run train https://multiqa.s3.amazonaws.com/config/MRQA_BERTLarge.json -s Models/MultiTrain -o "{'dataset_reader': {'sample_size': 75000}, 'validation_dataset_reader': {'sample_size': 1000}, 'train_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/train/SQuAD.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/NewsQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/HotpotQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/SearchQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/TriviaQA-web.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/train/NaturalQuestionsShort.jsonl.gz', 'validation_data_path': 'https://mrqa.s3.us-east-2.amazonaws.com/data/dev/SQuAD.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/NewsQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/HotpotQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/SearchQA.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/TriviaQA-web.jsonl.gz,https://mrqa.s3.us-east-2.amazonaws.com/data/dev/NaturalQuestionsShort.jsonl.gz', 'trainer': {'cuda_device': [0,1,2,3], 'num_epochs': '2', 'optimizer': {'type': 'bert_adam', 'lr': 3e-05, 'warmup': 0.1, 't_total': '145000'}}}" --include-package mrqa_allennlp`
 

 
 
## Making predictions
 
 `python predict.py model dataset outputfile `

Example for predicting SQuAD dev using BERTbase Multi-Task model: 

 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
 Specifying a GPU device:
 
 `python predict.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json --cuda_device 0`
 
### Evaluate 
 
 An example of using the official evaluation script on SQuAD development set with the model predictions generated in the previous section: 
 
 `python ../mrqa_official_eval.py https://s3.us-east-2.amazonaws.com/mrqa/data/dev/SQuAD.jsonl.gz pred-output.json`
 
## Results
 
Results are reported as EM/F1. I = in-domain, O = out-of-domain.

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
 
* Please note that these results refer to pre-processed versions and not official version of these datasets. (see our pre-processing description for details) 
## Server mode
To query a single JSON object in the MRQA format, start a server:
```
python serve.py https://s3.us-east-2.amazonaws.com/mrqa/models/BERT/_MIX_6.tar.gz 8888
```
To interact with the server, send a POST request:
```
curl -X POST -H "Content-Type: application/json" -d @NewsQA_single_sample.json localhost:8888
```
You should get the response, `{"f7b2f89be1724a9c86cbcc347b0c4425":"Harrison Ford"}`.

