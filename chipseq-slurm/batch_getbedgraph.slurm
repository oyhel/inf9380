#!/bin/bash
#SBATCH --job-name=b_getbedgraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load bedtools

cp data/sacisizes.txt $SCRATCH
cp N1_CHIP_sorted.bam $SCRATCH
cp N1_INPUT_sorted.bam $SCRATCH
cp T1_CHIP_sorted.bam $SCRATCH
cp T1_INPUT_sorted.bam $SCRATCH

chkfile N1_CHIP.bedGraph
chkfile N1_INPUT.bedGraph
chkfile T1_CHIP.bedGraph
chkfile T1_INPUT.bedGraph

# script
cd $SCRATCH

genomeCoverageBed -ibam N1_CHIP_sorted.bam -bg -g sacisizes.txt > N1_CHIP.bedGraph
genomeCoverageBed -ibam T1_CHIP_sorted.bam -bg -g sacisizes.txt > T1_CHIP.bedGraph
genomeCoverageBed -ibam T1_INPUT_sorted.bam -bg -g sacisizes.txt > T1_INPUT.bedGraph
genomeCoverageBed -ibam N1_INPUT_sorted.bam -bg -g sacisizes.txt > N1_INPUT.bedGraph

