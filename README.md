# DocILE: Document Information Localization and Extraction Benchmark With LiLt
---
Step to run trainings and inference.

Just clone it and config path.

---
### Train
**STEP 1 :**
* Setting trong file run_training.sh 

```
./docile/baselines/NER/run_training.sh
```
**LINES QUAN TRỌNG CẦN SỬA**:

LINE: 
* 20   run="lilt_base"
* 22   OUTPUT_DIR_PREFIX  : ĐƯỜNG DẪN TỚI OUTPUT FOLDER
* 24   NER_SCRIPTS_DIR    : ĐƯỜNG DẪN TỚI OUTPUT FOLDER CHỨA run_training.sh
* 25   CHECKPOINTS_DIR    : ĐƯỜNG DẪN TỚI FOLDER CHECKPOINT (chỉ cần khi train từ checkpoint)
* 28   DATA               : ĐƯỜNG DẪN TỚI FOLDER DATA DOCILE  (folder chứa train, val,..)
* 29  USE_PREPROCESSED : ĐƯỜNG DẪN TỚI FOLDER CHƯA PREPROCESSED DATA (data sau khi preprocessed sẽ đi vào đây)
* 30  OTHER_COMMON_PARAMS : CÁC PARAMETERS 

Here an example:
```
20  run="lilt_base"
21  TIMESTAMP=$(date +"%Y%m%d_%H%M_%S")
22  OUTPUT_DIR_PREFIX="/content/drive/MyDrive/docile_output"
23
24  NER_SCRIPTS_DIR="/content/docile/baselines/NER" 
25  CHECKPOINTS_DIR="/content/drive/MyDrive/docile_output" 
26
27  # Common parameters for all trainings with exception of roberta_pretraining
28  DATA="--docile_path /content/docile/data" 
29  USE_PREPROCESSED="--preprocessed_dataset_path /content/drive/MyDrive/newpreprocessed_dataset" 
30  OTHER_COMMON_PARAMS="--save_total_limit 1 --weight_decay 0.001 --lr 2e-5 --dataloader_num_workers 2 --use_BIO_format --tag_everything --report_all_metrics --stride 0" #PARAMETERS
31  COMMON_PARAMS="${DATA} ${USE_PREPROCESSED} ${OTHER_COMMON_PARAMS}"
32
33  # Used for synthetic pretraining of LayoutLMv3
34  USE_ARROW="--arrow_format_path /content/docile/preprocessed_dataset_arrow_format" #give it a fuck (không quan trọng)
```

***STEP 2:***

**NẾU KHÔNG CÓ CHECKPOINT**
* vẫn file run_training.sh dòng 85,86
* setting batch size, epoch,... tùy vào sức mạnh của server bạn :)
* model_name có thể thay bằng nhiều model LiLt khác trên Hugging Face
```
 85 train_params="--train_bs 1 --test_bs 1 --num_epochs 20 --gradient_accumulation_steps 1 --warmup_ratio 0"
 86 model="--model_name nielsr/lilt-xlm-roberta-base --use_lilt"
```
**NẾU CÓ CHECKPOINT**
* vẫn file run_training.sh dòng 85,86
* setting batch size, epoch,... tùy vào sức mạnh của server bạn :)
* sau ${CHECKPOINTS_DIR} tiếp tục dẫn đến folder checkpoint 
```
 85 train_params="--train_bs 1 --test_bs 1 --num_epochs 20 --gradient_accumulation_steps 1 --warmup_ratio 0"
 86 model="--model_name ${CHECKPOINTS_DIR}/lilt_base/20230428_0906_00/checkpoint-6739 --use_lilt"
```
***STEP 3:***
* Trong terminal tạo env var
```
export TOKENIZERS_PARALLELISM=true
```
* Sau đó chạy file run_training.sh để bắt đầu train
```
./run_training.sh
```
---
### Inference
STILL ON DEV









