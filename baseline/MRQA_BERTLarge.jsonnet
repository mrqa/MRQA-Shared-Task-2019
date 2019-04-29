{
    "dataset_reader": {
        "type": "mrqa_reader",
        "is_training":true,
        "sample_size": -1,
        "token_indexers": {
            "bert": {
                  "type": "bert-pretrained",
                  "pretrained_model": "bert-large-uncased",
                  "do_lowercase": true,
                  "use_starting_offsets": true
              }
        }
    },
    "validation_dataset_reader": {
        "type": "mrqa_reader",
        "lazy": true,
        "sample_size": -1,
        "token_indexers": {
            "bert": {
                  "type": "bert-pretrained",
                  "pretrained_model": "bert-large-uncased",
                  "do_lowercase": true,
                  "use_starting_offsets": true
              }
        }
    },
    
    "iterator": {
        "type": "mrqa_iterator",
        "batch_size": 6,
        "max_instances_in_memory": 1000
    },
    "model": {
        "type": "BERT_QA",
        "initializer": [],
        "text_field_embedder": {
            "allow_unmatched_keys": true,
            "embedder_to_indexer_map": {
                "bert": ["bert", "bert-offsets"]
            },
            "token_embedders": {
                "bert": {
                    "type": "bert-pretrained",
                    "pretrained_model": "bert-large-uncased",
                    "requires_grad":true
                }
            }
        }
    },
    "trainer": {
        "cuda_device": -1,
        "num_epochs": 2,
        "optimizer": {
            "type": "bert_adam",
            "lr": 0.00003,
            "warmup":0.1,
            "t_total": 29199
        },
        "patience": 10,
        "validation_metric": "+f1"
    },
    "validation_iterator": {
        "type": "mrqa_iterator",
        "batch_size": 6
    }
}