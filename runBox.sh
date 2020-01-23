#!/bin/bash
#SBATCH -N 1
#SBATCH --time=3:59:00
#SBATCH --mem=196000
#SBATCH -c 16
#SBATCH --array=1-50

export MATLABPATH='/tigress/WANG/mouseBehavior/leap/'
export HDF5_PLUGIN_PATH=/tigress/WANG/mouseBehavior/include/HDF5/plugins

cd $MATLABPATH

#source activate automice 

listOfFiles="/tigress/jverpeut/2019-06-Mouse-baseline_females/OFT_female_List2.txt"

rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
/usr/licensed/bin/matlab -nosplash -nodesktop -nodisplay -singleCompThread -nojvm -r "makeMouseBox2('$fileName','/tigress/jverpeut/2019-06-Mouse-baseline_females/box/'); exit;"

#source deactivate automice
