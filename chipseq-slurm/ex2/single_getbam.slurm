#!/bin/bash
#SBATCH --job-name=getbam
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools
module load bedtools

# Input: sam file to convert to bam
input=$1
# Output: name of output bam file 
output=$2

cp $input $SCRATCH

chkfile $output

# SCRIPT
cd $SCRATCH
time samtools view $input -bS > $output
