#!/bin/bash
#SBATCH --job-name=s_sortbam
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

# Input: bam file to sort
input=$1
# Output: sorted bam file output
output=$2

cp $input $SCRATCH

# script
cd $SCRATCH
time samtools sort $input $output
