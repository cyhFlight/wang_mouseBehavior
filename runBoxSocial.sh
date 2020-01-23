#!/bin/bash
#SBATCH -N 1
#SBATCH --time=1:59:00
#SBATCH -c 16
#SBATCH --array=1-38

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

listOfFiles="/tigress/mkislin/OFTsocial/data/raw/ASD_male_cup_List.txt"

rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox3('$fileName','/tigress/WANG/mouseBehavior/mouseBOX_social/'); exit;"
