#!/bin/bash
#SBATCH --job-name=sortBedGraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools
module load bamtools

input=$1
output=$2

chkfile $output

cp $input $SCRATCH

# script
time sort -k1,1 -k2,2n $input > $output
