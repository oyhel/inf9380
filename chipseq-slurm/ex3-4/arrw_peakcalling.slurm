#!/bin/bash
#SBATCH --job-name=aw_peakcalling
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load macs

echo "Task ID: " $TASK_ID

if [ $TASK_ID == 1 ]
then
    	input1='N1_CHIP.sam'
        input2='N1_INPUT.sam'
	output='N1'
elif [ $TASK_ID == 2 ]
then
    	input1='T1_CHIP.sam'
        input2='T1_INPUT.sam'
	output='T1'
else
    	exit 0
fi

cp $input1 $SCRATCH
cp $input2 $SCRATCH

chkfile ${output}_peaks.bed

# script
cd $SCRATCH
macs14 -t $input1 -c $input2 -n $output -g 2.23e6 -f SAM
