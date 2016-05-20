#!/bin/bash
#SBATCH --job-name=b_peakcalling
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load macs

cp N1_CHIP.sam $SCRATCH
cp N1_INPUT.sam $SCRATCH
cp T1_CHIP.sam $SCRATCH
cp T1_INPUT.sam $SCRATCH

chkfile N1_peaks.bed 
chkfile	T1_peaks.bed

# script
cd $SCRATCH

macs14 -t N1_CHIP.sam -c N1_INPUT.sam -n N1 -g 2.23e6 -f SAM
macs14 -t T1_CHIP.sam -c T1_INPUT.sam -n T1 -g 2.23e6 -f SAM
