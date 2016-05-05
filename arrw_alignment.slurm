#!/bin/bash
#SBATCH --job-name=alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

echo "Task ID: " $TASK_ID

if [ $TASK_ID == 1 ]
then
	input='N1_CHIP.fastq'
	output='N1_CHIP.sam'
elif [ $TASK_ID == 2 ]
then
	input='N1_INPUT.fastq'
	output='N1_INPUT.sam'
elif [ $TASK_ID == 3 ]
then
	input='T1_CHIP.fastq'
	output='T1_CHIP.sam'
elif [ $TASK_ID == 4 ]
then
	input='T1_INPUT.fastq'
	output='T1_INPUT.sam'
else
	exit 0
fi

module purge
module load bowtie

# copy files to compute node
cp data/saci* $SCRATCH
cp data/$input $SCRATCH

chkfile $output

# script
cd $SCRATCH
echo "Input file: " $input
echo "Output file: " $output
bowtie -S -v 2 -m 1 saci $input > $output

