#!/bin/bash
#SBATCH --job-name=batch-mergepeaks
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

cp N1_peaks.bed $SCRATCH
cp T1_peaks.bed $SCRATCH

chkfile N1_T1_merged_peaks.bed

# script
cd $SCRATCH

cat N1_peaks.bed T1_peaks.bed > N1_T1_peaks.bed
sort -k1,1 -k2,2n N1_T1_peaks.bed > N1_T1_sorted_peaks.bed
bedtools merge -i N1_T1_sorted_peaks.bed > N1_T1_merged_peaks.bed
