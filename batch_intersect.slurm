#!/bin/bash
#SBATCH --job-name=batch-mergepeaks 
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

cp N1_CHIP_sorted.bam $SCRATCH
cp T1_CHIP_sorted.bam $SCRATCH
cp N1_INPUT_sorted.bam $SCRATCH
cp T1_INPUT_sorted.bam $SCRATCH
cp N1_T1_merged_peaks.bed

chkfile	N1_CHIP_countR.txt
chkfile T1_CHIP_countR.txt
chkfile T1_INPUT_countR.txt
chkfile N1_INPUT_countR.txt

# script
cd $SCRATCH

intersectBed -bed -wb -abam N1_CHIP_sorted.bam -b N1_T1_merged_peaks.bed > N1_CHIP_intersect.txt
intersectBed -bed -wb -abam T1_CHIP_sorted.bam -b N1_T1_merged_peaks.bed > T1_CHIP_intersect.txt
intersectBed -bed -wb -abam N1_INPUT_sorted.bam -b N1_T1_merged_peaks.bed > N1_INPUT_intersect.txt
intersectBed -bed -wb -abam T1_INPUT_sorted.bam -b N1_T1_merged_peaks.bed > T1_INPUT_intersect.txt

cut -f13,14,15 N1_CHIP_intersect.txt | sort|uniq -c > N1_CHIP_ib_count.txt
cut -f13,14,15 T1_CHIP_intersect.txt | sort|uniq -c > T1_CHIP_ib_count.txt
cut -f13,14,15 T1_INPUT_intersect.txt | sort|uniq -c > T1_INPUT_ib_count.txt
cut -f13,14,15 N1_INPUT_intersect.txt | sort|uniq -c > N1_INPUT_ib_count.txt

awk '{print $2"_"$3"_"$4"\t"$1}' N1_CHIP_ib_count.txt > N1_CHIP_countR.txt
awk '{print $2"_"$3"_"$4"\t"$1}' T1_CHIP_ib_count.txt > T1_CHIP_countR.txt
awk '{print $2"_"$3"_"$4"\t"$1}' T1_INPUT_ib_count.txt > T1_INPUT_countR.txt
awk '{print $2"_"$3"_"$4"\t"$1}' N1_INPUT_ib_count.txt > N1_INPUT_countR.txt
