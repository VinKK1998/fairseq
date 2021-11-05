#!/bin/bash
#SBATCH -J mfcc-extract                      # 作业名
#SBATCH -o slurm-%j-mfcc.out                       # 屏幕上的输出文件重定向到 slurm-%j.out , %j 会替换成jobid
#SBATCH -p compute                               # 作业提交的分区为 compute
#SBATCH -N 1                                     # 作业申请 1 个节点
#SBATCH -t 2-00:00:00                            # 任务运行的最长时间为 1 小时
#SBATCH -w gpu15                                 # 指定运行作业的节点
#SBATCH --cpus-per-task=24
#SBATCH --mem=200000

pwd; hostname;
TIME=$(date -Iseconds)
echo $TIME
source ~/.bashrc
conda activate py38-torch

# python examples/hubert/simple_kmeans/dump_mfcc_feature.py /users10/wtxia/AISHELL-2/iOS/data dev 1 0 /users10/wtxia/AISHELL-2/hubert_pretrain_prepared
# python examples/hubert/simple_kmeans/dump_mfcc_feature.py /users10/wtxia/AISHELL-2/iOS/data test 1 0 /users10/wtxia/AISHELL-2/hubert_pretrain_prepared
python examples/hubert/simple_kmeans/dump_mfcc_feature.py /users10/wtxia/AISHELL-2/iOS/data train 1 0 /users10/wtxia/AISHELL-2/hubert_pretrain_prepared

TIME=$(date -Iseconds)
echo $TIME