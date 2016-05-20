#!/bin/bash
#SBATCH --job-name=s_intersect
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

# Input: name of sorted bam file to find intersections in
input1=$1
# Input: name of merged peaks bed file
input2=$2
# Output: name of R formatted reads file 
output=$3

cp $input $SCRATCH
cp N1_T1_merged_peaks.bed $SCRATCH

chkfile $output

# script
cd $SCRATCH

run_script(){
	intersectBed -bed -wb -abam $input1 -b $input2 > tmp_intersect.txt
	cut -f13,14,15 tmp_intersect.txt | sort | uniq -c > tmp_ib_count.txt
	awk '{print $2"_"$3"_"$4"\t"$1}' tmp_ib_count.txt > $output
}

time run_script
