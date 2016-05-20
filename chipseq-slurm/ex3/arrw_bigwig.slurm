#!/bin/bash
#SBATCH --job-name=aw_bigwig
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge

echo "Task ID: " $TASK_ID

if [ $TASK_ID == 1 ]
then
    	input='N1_CHIP_sorted.bedGraph'
        output='N1_CHIP_bigWig.bwig'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT_sorted.bedGraph'
        output='N1_INPUT_bigWig.bwig'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP_sorted.bedGraph'
        output='T1_CHIP_bigWig.bwig'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT_sorted.bedGraph'
        output='T1_INPUT_bigWig.bwig'
else
    	exit 0
fi

cp $input $SCRATCH
cp ../data/sacisizes.txt $SCRATCH
cp ../programs/bedGraphToBigWig $SCRATCH

chkfile $output

# script
cd $SCRATCH
chmod 755 bedGraphToBigWig
./bedGraphToBigWig -unc $input sacisizes.txt $output
