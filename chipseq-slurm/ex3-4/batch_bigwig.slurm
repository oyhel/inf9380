#!/bin/bash
#SBATCH --job-name=b_bigwig
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge

cp programs/bedGraphToBigWig $SCRATCH
cp data/sacisizes.txt $SCRATCH
cp N1_CHIP_sorted.bedGraph $SCRATCH
cp N1_INPUT_sorted.bedGraph $SCRATCH
cp T1_CHIP_sorted.bedGraph $SCRATCH
cp T1_INPUT_sorted.bedGraph $SCRATCH

chkfile N1_CHIP_bigWig.bwig
chkfile N1_INPUT_bigWig.bwig
chkfile T1_INPUT_bigWig.bwig
chkfile T1_CHIP_bigWig.bwig

# script
cd $SCRATCH
chmod 755 bedGraphToBigWig
./bedGraphToBigWig -unc N1_INPUT_sorted.bedGraph sacisizes.txt N1_INPUT_bigWig.bwig
./bedGraphToBigWig -unc T1_INPUT_sorted.bedGraph sacisizes.txt T1_INPUT_bigWig.bwig
./bedGraphToBigWig -unc T1_CHIP_sorted.bedGraph sacisizes.txt T1_CHIP_bigWig.bwig
./bedGraphToBigWig -unc N1_CHIP_sorted.bedGraph sacisizes.txt N1_CHIP_bigWig.bwig
