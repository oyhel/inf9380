#!/bin/bash
#SBATCH --job-name=s_mergepeaks
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

# Input: first bed file for merging
input1=$1
# Input: second bed file for merging
input2=$2
# Output: name of merged peaks bed file
output=$2

chkfile $output

cp $input1 $SCRATCH
cp $input2 $SCRATCH

# script
cd $SCRATCH
cat $input1 $input2 > tmp_peaks.bed
sort -k1,1 -k2,2n tmp_peaks.bed > tmp_sorted_peaks.bed
bedtools merge -i tmp_sorted_peaks.bed > $output
