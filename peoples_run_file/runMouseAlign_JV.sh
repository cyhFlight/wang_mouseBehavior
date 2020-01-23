#!/bin/bash
#SBATCH -N 1
#SBATCH --time=4:59:00
#SBATCH --mem=64000
#SBATCH -c 16 
#SBATCH --array=1-56 

export MATLABPATH='/home/klibaite/leap'
export HDF5_PLUGIN_PATH=/tigress/klibaite/include/HDF5/plugins

cd $MATLABPATH

source activate automice 

listOfFiles="/tigress/jverpeut/FMB_DREADD5/box/FMB_DREADD5_BOX_List.txt"

rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "cd('$MATLABPATH'); mouseAlign('$fileName','/tigress/jverpeut/FMB_DREADD5/aligned/'); exit;"

source deactivate automice
