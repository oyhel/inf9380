#!/bin/bash
#SBATCH --job-name=aw_getbam
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
    	input='N1_CHIP.sam'
        output='N1_CHIP.bam'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT.sam'
        output='N1_INPUT.bam'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP.sam'
        output='T1_CHIP.bam'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT.sam'
        output='T1_INPUT.bam'
else
    	exit 0
fi

cp $input $SCRATCH

chkfile $output

# SCRIPT
cd $SCRATCH
echo "Input file: " $input
echo "Output file: " $output

samtools view $input -bS > $output
