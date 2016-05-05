#!/bin/bash
#SBATCH --job-name=aw_sortbam
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

echo "Task ID: " $TASK_ID

if [ $TASK_ID == 1 ]
then
    	input='N1_CHIP.bam'
        output='N1_CHIP_sorted'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT.bam'
        output='N1_INPUT_sorted'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP.bam'
        output='T1_CHIP_sorted'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT.bam'
        output='T1_INPUT_sorted'
else
    	exit 0
fi

cp $input $SCRATCH

chkfile ${output}.bam

# SCRIPT
cd $SCRATCH
echo "Input file: " $input
echo "Output file: " $output

samtools sort $input $output

