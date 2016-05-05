#!/bin/bash
#SBATCH --job-name=mpi-alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

cp N1_CHIP.bam $SCRATCH
cp N1_INPUT.bam $SCRATCH
cp T1_CHIP.bam $SCRATCH
cp T1_INPUT.bam $SCRATCH

chkfile N1_CHIP_sorted.bam
chkfile N1_INPUT_sorted.bam
chkfile T1_CHIP_sorted.bam
chkfile T1_INPUT_sorted.bam

# script
cd $SCRATCH

samtools sort N1_INPUT.bam N1_INPUT_sorted
samtools sort T1_INPUT.bam T1_INPUT_sorted
samtools sort T1_CHIP.bam T1_CHIP_sorted
samtools sort N1_CHIP.bam N1_CHIP_sorted
