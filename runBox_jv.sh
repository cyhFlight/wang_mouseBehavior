#!/bin/bash
#SBATCH -N 1
#SBATCH --time=2:59:00
#SBATCH --mem=150000
#SBATCH -c 16
#SBATCH --array=1-56

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

listOfFiles="/tigress/jverpeut/FMB_DREADD5/FMB_DREADD5.txt"


rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox3('$fileName','/tigress/jverpeut/FMB_DREADD5/box'); exit;"

#source deactivate automice
