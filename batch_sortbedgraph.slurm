#!/bin/bash
#SBATCH --job-name=batch-sortbedgraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load samtools

cp N1_CHIP.bedGraph $SCRATCH
cp N1_INPUT.bedGraph $SCRATCH
cp T1_CHIP.bedGraph $SCRATCH
cp T1_INPUT.bedGraph $SCRATCH

chkfile N1_CHIP_sorted.bedGraph
chkfile N1_INPUT_sorted.bedGraph
chkfile T1_CHIP_sorted.bedGraph
chkfile N1_CHIP_sorted.bedGraph

# script
cd $SCRATCH

sort -k1,1 -k2,2n N1_INPUT.bedGraph > N1_INPUT_sorted.bedGraph
sort -k1,1 -k2,2n T1_INPUT.bedGraph > T1_INPUT_sorted.bedGraph
sort -k1,1 -k2,2n T1_CHIP.bedGraph > T1_CHIP_sorted.bedGraph
sort -k1,1 -k2,2n N1_CHIP.bedGraph > N1_CHIP_sorted.bedGraph
