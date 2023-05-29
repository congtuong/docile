#!/bin/bash

set -euo pipefail

#Path to main.cfg
. ./config/main.cfg



# Set GPU device number to use, enforced with CUDA_VISIBLE_DEVICES=${GPU}
GPU="${GPU_ID}"

# Choose for which NER baseline you want to run the training. You can run multiple trainings
# consecutively by separating them by space but beware that they run in the order in which they are
# listed at the bottom of this file, not by the order in the `run` list.
run="lilt_base"
TIMESTAMP=$(date +"%Y%m%d_%H%M_%S")
OUTPUT_DIR_PREFIX=${OUTPUT_DIR}

# NER_SCRIPTS_DIR="./baselines/NER"
# CHECKPOINTS_DIR="./checkpoint"

# # Common parameters for all trainings with exception of roberta_pretraining
DATA="--docile_path ${MAIN_DATA}" 
USE_PREPROCESSED="--preprocessed_dataset_path ${PREPROCESSED}"
OTHER_COMMON_PARAMS="--save_total_limit 2 --weight_decay 0.001 --lr 2e-5 --dataloader_num_workers 2 --use_BIO_format --tag_everything --report_all_metrics --stride 0"
COMMON_PARAMS="${DATA} ${USE_PREPROCESSED} ${OTHER_COMMON_PARAMS}"

# Used for synthetic pretraining of LayoutLMv3
# USE_ARROW="--arrow_format_path /content/docile/preprocessed_dataset_arrow_format"
function run_training() {
  cmd=$1
  output_dir="${OUTPUT_DIR_PREFIX}/$2"
  shift ; shift
  params="$@ --output_dir ${output_dir}"

  mkdir -p ${output_dir}
  log="${output_dir}/log_train.txt"

  training_cmd="CUDA_LAUNCH_BLOCKING=1 TF_FORCE_GPU_ALLOW_GROWTH=\"true\" TORCH_USE_CUDA_DSA=true CUDA_VISIBLE_DEVICES=${GPU} python3 ${NER_SCRIPTS_DIR}/${cmd} ${params} 2>&1 | tee ${log}"

  echo "-----------"
  echo "Parameters:"
  echo "-----------"
  echo ${params}
  echo "-----------"
  echo "Running ${training_cmd}"
  echo "-----------"
  echo "==========="

  eval ${training_cmd}
}
TOKENIZERS_PARALLELISM=true
# python -m 
CMD_ROBERTA_PRETRAIN="docile_pretrain_BERT_onfly.py"
CMD_ROBERTA="docile_train_NER_multilabel.py"

single_run="lilt_base"
if [[ " ${run} " =~ " ${single_run} " ]]; then
  train_params="--train_bs ${TRAIN_BS} --test_bs ${TEST_BS} --num_epochs ${MAX_EPOCH} --gradient_accumulation_steps 1 --warmup_ratio 0"
  model="--model_name nielsr/lilt-xlm-roberta-base --use_lilt"
  all_params="${COMMON_PARAMS} ${train_params} ${model}"
  output_dir="${single_run}/${TIMESTAMP}"
  run_training ${CMD_ROBERTA} ${output_dir} ${all_params}
fi

