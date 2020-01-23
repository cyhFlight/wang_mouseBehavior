#!/bin/bash
#SBATCH -N 1
#SBATCH --time=4:59:00
#SBATCH --mem=64000
#SBATCH -c 16 
#SBATCH --array=1 

export MATLABPATH='/home/klibaite/leap'
export HDF5_PLUGIN_PATH=/tigress/klibaite/include/HDF5/plugins

cd $MATLABPATH

source activate automice 

# listOfFiles="/tigress/jverpeut/2019-06-Mouse-baseline_females/OFT_female_BOX_List.txt"

# rowNumber=$SLURM_ARRAY_TASK_ID
# fileName=$(sed "${rowNumber}q;d" $listOfFiles)

/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "cd('$MATLABPATH'); mouseAlign('/tigress/WANG/mouseBehavior/mouseBOX_social/OFTsocial-0090-00_box.h5','/tigress/WANG/mouseBehavior/mouseBOX_social/mouseAligned/'); exit;"

source deactivate automice

