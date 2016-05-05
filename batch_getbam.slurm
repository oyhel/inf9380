#!/bin/bash
#SBATCH --job-name=mpi-alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

cp N1_CHIP.sam $SCRATCH
cp N1_INPUT.sam $SCRATCH
cp T1_CHIP.sam $SCRATCH
cp T1_INPUT.sam $SCRATCH

chkfile N1_CHIP.bam
chkfile N1_INPUT.bam
chkfile T1_CHIP.bam
chkfile T1_INPUT.bam

# script
cd $SCRATCH

samtools view N1_CHIP.sam -bS > N1_CHIP.bam
samtools view T1_CHIP.sam -bS > T1_CHIP.bam
samtools view N1_INPUT.sam -bS > N1_INPUT.bam
samtools view T1_INPUT.sam -bS > T1_INPUT.bam

