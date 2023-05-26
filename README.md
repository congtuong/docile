# DocILE: Document Information Localization and Extraction Benchmark With LiLt
---
This repository contains our source code of both Task 1 and Task 2 in the DocILE Competition.

---
### Introduction
DocILE is a large-scale research benchmark for cross-evaluation of machine learning methods for Key Information Localization and Extraction (KILE) and Line Item Recognition (LIR) from semi-structured business documents such as invoices, orders etc. Such large-scale benchmark was previously missing  [(Skalický et al., 2022)](https://link.springer.com/chapter/10.1007/978-3-031-13643-6_8), hindering comparative evaluation.

* This repository this repository contain our source code to use [LiLT: A Simple yet Effective Language-Independent Layout Transformer for Structured Document Understanding](https://arxiv.org/abs/2202.13669) 

### Installing
###### Requirements
We're using Python 3.9 to run this repo:
**Requirements packages:**
* poppler-utils
* tensorboard
* jsonargparse[signatures]
* tensorrt==8.5.1.7
* timm
* transformers==4.26.0
* datasets==2.11.0

###### Install
Run this command to install requirements:
```bash
pip install -r requirements.txt
```
### Config
Change config in ./config/train.cfg to suit your enviroments.
Change path to config file in ./run_training.sh and ./run_inference.sh to suit your enviroments.
### Resplit dataset
We decided to randomly resplit dataset, 80% for train and 20% for validation to have better score.
To randomly resplit dataset, change dataset_path in ./data_split.py and run:
```
python3 data_split.py
```
### Train
Run ./run_training.sh
```bash
bash run_training.sh
```
The models will be save at OUPUT_DIR (config)
### Inference
To run inference, follow below instruction.
* On test set, call:
```bash
bash run_inference.sh test
```
* On validation set, call:
```bash
bash run_inference.sh val
```
The result will be save at PREDICTION_DIR (con)
### Contributing

### Links 
https://huggingface.co/docs/transformers/model_doc/lilt

https://docile.rossum.ai/
