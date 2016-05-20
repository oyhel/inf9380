#!/bin/bash
#SBATCH --job-name=alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bowtie

# Input: The fastq file	for alignment
input=$1
# Output: Name of output sam	file
output=$2

# copy files to compute node
cp ../data/saci* $SCRATCH
cp $input $SCRATCH 

chkfile $output

cd $SCRATCH
inputfile=`basename $input`
time bowtie -S -v 2 -m 1 saci $inputfile  > $output
