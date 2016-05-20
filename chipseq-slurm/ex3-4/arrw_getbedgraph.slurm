#!/bin/bash
#SBATCH --job-name=aw_getbedgraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

echo "Task ID: " $TASK_ID

if [ $TASK_ID == 1 ]
then
    	input='N1_CHIP_sorted.bam'
        output='N1_CHIP.bedGraph'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT_sorted.bam'
        output='N1_INPUT.bedGraph'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP_sorted.bam'
        output='T1_CHIP.bedGraph'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT_sorted.bam'
        output='T1_INPUT.bedGraph'
else
    	exit 0
fi

cp $input $SCRATCH
cp ../data/sacisizes.txt $SCRATCH

chkfile $output

# script
cd $SCRATCH
genomeCoverageBed -ibam $input -bg -g sacisizes.txt > $output

