#!/bin/bash
#SBATCH --job-name=aw_intersect
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
	prefix='N1_CHIP'
	output='N1_CHIP_countR.txt'
elif [ $TASK_ID == 2 ]
then
    	input='N1_INPUT_sorted.bam'
	prefix='N1_INPUT'
	output='N1_INPUT_countR.txt'
elif [ $TASK_ID == 3 ]
then
    	input='T1_CHIP_sorted.bam'
	prefix='T1_CHIP'
	output='T1_CHIP_countR.txt'
elif [ $TASK_ID == 4 ]
then
    	input='T1_INPUT_sorted.bam'
	prefix='T1_INPUT'
	output='T1_INPUT_countR.txt'
else
    	exit 0
fi

cp $input $SCRATCH
cp N1_T1_merged_peaks.bed $SCRATCH

chkfile $output

# script
cd $SCRATCH

run_script() {
	intersectBed -bed -wb -abam $input -b N1_T1_merged_peaks.bed > ${prefix}_intersect.txt
	cut -f13,14,15 ${prefix}_intersect.txt | sort | uniq -c > ${prefix}_ib_count.txt
	awk '{print $2"_"$3"_"$4"\t"$1}' ${prefix}_ib_count.txt > ${prefix}_countR.txt
}

time run_script
