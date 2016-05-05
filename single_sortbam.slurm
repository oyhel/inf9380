#!/bin/bash
#SBATCH --job-name=single_sortbam
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

input=$1
output=$2

cp $input $SCRATCH

# script content

cd $SCRATCH
time samtools sort $input $output
