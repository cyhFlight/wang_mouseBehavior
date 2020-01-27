# Instructions for Wang lab video processing pipeline

## First time set up

1. Log onto Della and navigate to the directory where yo want to keep the scripts
2. Git clone this repo to your folder by
``` bash
git clone https://github.com/cyhFlight/wang_mouseBehavior
```
Alternatively, just copy everything from my scripts folder by 
`cp /tigress/yuhang/wang_lab/scripts /YOURFOLDER`

3. Copy folder wang_mouseBehavior/bin/ to your own HOME folder
``` bash
cp codes/wang_mouseBehavior/bin/ ~/
```
4. `cd /wang_mouseBehavior/sbatch_scripts/sbatchTemplates/`

Edit all *.sbTemp* files. Change the #SBATCH line about the __email__ to receive notifications.

## Moving processing and alignment
1. On Della, navigate to folder with all movies to process, make symbolic links for sbatch tamplates by 
``` bash
ln -s ~/codes/wang_mouseBehavior/sbatch_scripts/sbatchTemplates/ ./
```
2. Run (by just entering) 
```
init_dir.sh
```
This will generate all the *List.txt* files and *sbatch* files you need.
3. On DELLA submit the job via slurm 
```
sbatch 1_runBox.sb
```
4. Wait until the job finishes. You should get emails about it.
*If fails, check the slurm output files under /projects/WANG/mouseBehavior/slurm_logs/ for error messages*

\*After it is done, check box movies in savePath by plotting mouseDataBox from '\*\_box_data.mat' 
\*check videos with plotcentroidbox.JV. You need to open matlab as:
```
/usr/licensed/bin/matlab-R2017b -nosplash -nodesktop -nodisplay -singleCompThread -r MATLAB_command
```
5. Switch to TIGER_GPU, and go to the same folder, submit the next job 
```
sbatch 2_predAlignMouse.sb
```
6. Wait for the job to finish. Then switch back to Della folder to submit the next job
```
sbatch 3_runMouseAlign.sb
```
7. Wait for the job to finish.
\*check videos with plotcentroidaligned.JV with MATLAB
```
/usr/licensed/bin/matlab-R2017b -nosplash -nodesktop -nodisplay -singleCompThread -r MATLAB_command
```
8. Log onto TIGER_GPU, in the same folder to submit
```
sbatch 4_predMultMouse_JV.sb
```
9. The output .h5 files are all in leapout/ folder.

*LEAP network for alignments: 181023_131517-n=399*  
*LEAP network for labeling joints: mouseBox_trainingSet_cluster_6-leap_cnn_epochs=50*

## Clustering

Then locally open the masterscript_DREADD

1) Run FromFilesIDstoCellaray.m
2) run masterScript_DREADD.m
	This part may take a long time.
3) Make text file using cmd: 
	navigate to folder by just typing the folder whole path then:
	dir *.mat /s /b > printit.txt
4)run Distance -> PCA
  Variance explained to select number of projections (missing code)
5)PCA projections: plot(1-(vals./sum(vals)))
6)Go to SPOCK to run on cluster (spock.princeton.edu)
	edit runSubs_jv.sh if needed 
	only 20 projections
	printf '%s\n' "$PWD"/*20.mat > projections20.txt
	sbatch runSubs_jv.sh (squeue -u jverpeut  to check progress)
7) Make the trainingsetData list which is next in the code locally
8) K means clusting: In cluster utilities...edit runC_JV.sh
run in spock
navigate to folder: cd /jukebox/wang_mkislin/OldData/Jess/code_and_dataset/mouse-behavior/cluster_utilities
sbatch runC_jv.sh
1:10, MaxIter 100, replicate 20, 54 hours

9) open runRE_HDK_jv.sh for editing
	change SBATCH array for size
	change all paths
10) put all aligned mat files into one folder
