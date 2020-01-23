#!/usr/bin/bash
#SBATCH -job-name=prdAM
#SBATCH --time=1:59:00
#SBATCH --mem=128000
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=yuhangc@princeton.edu
#SBATCH -D /projects/WANG/mouseBehavior/leap/
#SBATCH -o /projects/WANG/mouseBehavior/slurm_logs/slurm-%A_%a.out # STDOUT
#SBATCH --gres=gpu:1
#SBATCH --array=1-3

source /home/klibaite/.bashrc
source activate fly

listOfFiles="/tigress/yuhangc/wang_lab/test_run/box/TEST_BOX_List.txt"
listOfSaves="/tigress/yuhangc/wang_lab/test_run/box/TEST_PRED_List.txt"
rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
saveName=$(sed "${rowNumber}q;d" $listOfSaves)

python /home/klibaite/leap/leap/predict_box.py \
       $fileName \
       /tigress/SHAEVITZ/klibaite/181023_131517-n=399 \
       $saveName
source deactivate
