#!/bin/bash
#SBATCH --job-name=getBedGraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools
module load bedtools

input=$1
output=$2

chkfile $output

cp $input $SCRATCH
cp data/sacisizes.txt $SCRATCH

# script

cd $SCRATCH
time genomeCoverageBed -ibam $input -bg -g sacisizes.txt > $output
