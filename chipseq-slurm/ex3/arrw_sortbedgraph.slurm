#!/bin/bash
#SBATCH --job-name=aw_sortbedgraph
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
    	input='N1_CHIP.bedGraph'
        output='N1_CHIP_sorted.bedGraph'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT.bedGraph'
        output='N1_INPUT_sorted.bedGraph'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP.bedGraph'
        output='T1_CHIP_sorted.bedGraph'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT.bedGraph'
        output='T1_INPUT_sorted.bedGraph'
else
    	exit 0
fi

cp $input $SCRATCH

chkfile $output

# SCRIPT
cd $SCRATCH
echo "Input file: " $input
echo "Output file: " $output

sort -k1,1 -k2,2n $input > $output
