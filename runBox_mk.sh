#!/bin/bash
#SBATCH -N 1
#SBATCH --time=3:59:00
#SBATCH --mem=150000
#SBATCH -c 16
#SBATCH --array=1-1

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

listOfFiles="/tigress/mkislin/OFTephys/EPHYS2_List.txt"

rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox2mk('$fileName','/tigress/mkislin/OFTephys/box/'); exit;"

#source deactivate automice
