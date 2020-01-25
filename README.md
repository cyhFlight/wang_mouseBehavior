# Instructions for Wang lab video processing pipeline

## First time set up

1. On Della, in your home folder, create two folders by running 'mkdir -p bin codes'
2. Git this repo to your folder on Della under /codes, or run 'cp /tigress/yuhang/wang_lab/scripts ~/codes/'
3. Copy all files (or create symbolic links) from scripts/bin/ to your own ~/bin/ folder
4. Go to /codes/scripts/sbatch_scripts/sbatchTemplates/, edit .sbTemp files about the email notification.

---MOVING PROCESSING AND ALIGNMENT---
. On Della, navigate to folder with all movies for analysis, make symbolic links by 
	'ln -s ~/codes/scripts/sbatch_scripts/sbatchTemplates/ ./'
. Run (by just entering) init_dir.sh
	This will generate all the List.txt files and sbatch files you need
. On DELLA run code: 'sbatch 1_runBox.sb'
. Wait until the job finishes. You should get emails about it.
	*check box movies in savePath by plotting mouseDataBox from '*_box_data.mat'
	*check videos with plotcentroidbox.JV
		need to open matlab as: 
		/usr/licensed/bin/matlab-R2017b -nosplash -nodesktop -nodisplay -singleCompThread -r MATLAB_command
	**If fails, check the slurm output files under /projects/WANG/mouseBehavior/slurm_logs/
. Switch to TIGER_GPU, and go to the same folder, run code: 'sbatch 2_predAlignMouse.sb'
. Wait for the job to finish. Then switch back to Della folder
. Run 'sbatch 3_runMouseAlign.sb'
. Wait for the job to finish.
	*check videos with plotcentroidaligned.JV
	need to open matlab as: /usr/licensed/bin/matlab-R2017b -nosplash -nodesktop -nodisplay -singleCompThread -r MATLAB_command
. Log onto TIGER_GPU, in the same folder run: 'sbatch 4_predMultMouse_JV.sb'

11 Move predicted2 files to leapout
* should be done by change the MATLAB code above (from aligned/ to leapout/)

LEAP network for alignments: 181023_131517-n=399
LEAP network for labeling joints: mouseBox_trainingSet_cluster_6-leap_cnn_epochs=50

---Clustering---

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
