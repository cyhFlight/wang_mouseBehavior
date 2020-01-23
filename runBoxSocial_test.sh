#!/bin/bash
#SBATCH -N 1
#SBATCH --time=1:59:00
#SBATCH -c 16
#SBATCH --array=1

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox3_manual('/tigress/mkislin/OFTsocial/data/raw/OFTsocial-0090-00.h5','/tigress/WANG/mouseBehavior/mouseBOX_social/'); exit;"

