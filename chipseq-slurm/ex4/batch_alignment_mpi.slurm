#!/bin/bash
#SBATCH --job-name=b_mpi-alignment
#SBATCH --account=ln0002k
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bowtie
module load pmap

cp ../data/saci* $SCRATCH
cp ../data/N1_CHIP.fastq $SCRATCH
cp ../data/N1_INPUT.fastq $SCRATCH
cp ../data/T1_CHIP.fastq $SCRATCH
cp ../data/T1_INPUT.fastq $SCRATCH

chkfile N1_CHIP.sam
chkfile N1_INPUT.sam
chkfile T1_CHIP.sam
chkfile T1_INPUT.sam

# script
cd $SCRATCH

mpirun -np 8 pmap_dist . . N1_CHIP.fastq -i . saci
mpirun -np 8 pmap -i . saci . . bowtie -S -v 2 -m 1
awk 'NR <= 3 || !/^@/' < out.txt > N1_CHIP.sam

mpirun -np 8 pmap_dist . . N1_INPUT.fastq -i . saci
mpirun -np 8 pmap -i . saci . . bowtie -S -v 2 -m 1
awk 'NR <= 3 || !/^@/' < out.txt > N1_INPUT.sam

mpirun -np 8 pmap_dist . . T1_CHIP.fastq -i . saci
mpirun -np 8 pmap -i . saci . . bowtie -S -v 2 -m 1
awk 'NR <= 3 || !/^@/' < out.txt > T1_CHIP.sam

mpirun -np 8 pmap_dist . . T1_INPUT.fastq -i . saci
mpirun -np 8 pmap -i . saci . . bowtie -S -v 2 -m 1
awk 'NR <= 3 || !/^@/' < out.txt > T1_INPUT.sam
