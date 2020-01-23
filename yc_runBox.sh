#!/bin/bash
#SBATCH --job-name=videoMATLAB
#SBATCH -N 1
#SBATCH --time=2:59:00
#SBATCH --mem=150000
#SBATCH -c 16
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=yuhangc@princeton.edu
#SBATCH -o /projects/WANG/mouseBehavior/slurm_logs/slurm-%A_%a.out # STDOUT
#SBATCH -D /projects/WANG/mouseBehavior/
#SBATCH --array=1-10

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

listOfFiles="/tigress/yuhangc/wang_lab/test_run/TEST_List.txt"
rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox3('$fileName','/tigress/yuhangc/wang_lab/test_run/box'); exit;"

#source deactivate automice
