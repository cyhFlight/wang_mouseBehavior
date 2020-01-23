#! /usr/bin/bash

#mkdir box aligned leapout
#chmod 0777 box aligned leapout

# gets the PWD folder name as header
export HEADER=`pwd |awk -F / '{print $NF}'`
echo $HEADER
# the list of .h5
VIDEOS=`ls ${PWD}\/*.h5`
echo $VIDEOS
$VIDEOS >> ${HEADER}_List.txt
