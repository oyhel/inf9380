#!/bin/bash
#SBATCH --job-name=alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bowtie

cp data/saci* $SCRATCH
cp data/N1_CHIP.fastq $SCRATCH
cp data/N1_INPUT.fastq $SCRATCH
cp data/T1_CHIP.fastq $SCRATCH
cp data/T1_INPUT.fastq $SCRATCH

chkfile N1_CHIP.sam
chkfile N1_INPUT.sam
chkfile T1_CHIP.sam
chkfile T1_INPUT.sam

# script
cd $SCRATCH
bowtie -p 7 -S -v 2 -m 1 data/saci data/N1_CHIP.fastq > N1_CHIP.sam
bowtie -p 7 -S -v 2 -m 1 data/saci data/N1_INPUT.fastq > N1_INPUT.sam
bowtie -p 7 -S -v 2 -m 1 data/saci data/T1_CHIP.fastq > T1_CHIP.sam
bowtie -p 7 -S -v 2 -m 1 data/saci data/T1_INPUT.fastq > T1_INPUT.sam
