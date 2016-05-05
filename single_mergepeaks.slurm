#!/bin/bash
#SBATCH --job-name=s_mergepeaks
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge

input=$1
output=$2

chkfile $bigwigout

cp $input $SCRATCH
cp data/sacisizes.txt $SCRATCH
cp programs/bedGraphToBigWig $SCRATCH

# script
cd $SCRATCH

chmod 755 bedGraphToBigWig
time ./bedGraphToBigWig -unc $input sacisizes.txt $output

