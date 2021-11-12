#!/bin/bash
#SBATCH -J hubert-pretrain                       # 作业名
#SBATCH -o slurm-%j-hubert.out                       # 屏幕上的输出文件重定向到 slurm-%j.out , %j 会替换成jobid
#SBATCH -e slurm-%j-hubert.err 
#SBATCH -p compute                              # 作业提交的分区为 compute
#SBATCH -N 1                                    # 作业申请 1 个节点
#SBATCH -n 1 
#SBATCH -t 7-00:00:00                            # 任务运行的最长时间为 1 小时
#SBATCH -w gpu27                                 # 指定运行作业的节点
#SBATCH --gres=gpu:a100-pcie-40gb:4

pwd; hostname;
TIME=$(date -Iseconds)
echo $TIME
source ~/.bashrc
conda activate py38-torch

python -m debugpy --listen 0.0.0.0:55557 fairseq_cli/hydra_train.py \
  --config-dir examples/hubert/config/pretrain \
  --config-name hubert_base_librispeech \
  task.data=/users8/wtxia/dev/fairseq/datasets \
  task.label_dir=/users8/wtxia/dev/fairseq/datasets \
  task.labels='["km"]' \
  model.label_rate=100q