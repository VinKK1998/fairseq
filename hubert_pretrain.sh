#!/bin/bash
#SBATCH -J wav2vec2-c                        # 作业名
#SBATCH -o slurm-%j-wav2vec2c.out                       # 屏幕上的输出文件重定向到 slurm-%j.out , %j 会替换成jobid
#SBATCH -e slurm-%j-wav2vec2c.err                       # 屏幕上的错误输出文件重定向到 slurm-%j.err , %j 会替换成jobid
#SBATCH -p compute                              # 作业提交的分区为 compute
#SBATCH -N 1                                    # 作业申请 1 个节点
#SBATCH -n 1 
#SBATCH -t 1-00:00:00                            # 任务运行的最长时间为 1 小时
#SBATCH -w gpu26                               # 指定运行作业的节点
#SBATCH --gres=gpu:a100-pcie-40gb:1

pwd; hostname;
TIME=$(date -Iseconds)
echo $TIME
source ~/.bashrc
conda activate py38-torch

python -m debugpy --listen 0.0.0.0:55557 fairseq_cli/hydra_train.py \
  --config-dir examples/hubert/config/pretrain \
  --config-name hubert_base_librispeech \
  task.data=/users10/wtxia/AISHELL-2/hubert_pretrain_prepared_done \
  task.label_dir=/users10/wtxia/AISHELL-2/hubert_pretrain_prepared_done \
  task.labels='["km"]' \
  model.label_rate=100