#!/bin/bash
#SBATCH --job-name=s_normalization
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load R

cp ../programs/makeplots.R $SCRATCH
cp N1_CHIP_countR.txt $SCRATCH
cp T1_CHIP_countR.txt $SCRATCH
cp T1_INPUT_countR.txt $SCRATCH
cp N1_INPUT_countR.txt $SCRATCH

chkfile readcount_plot_N1c.pdf
chkfile readcount_plot_T1c.pdf
chkfile readcount_plot_CHIP_N1c_T1c.pdf
chkfile histogram_logfoldChange_quantile_normalized_counts.pdf
chkfile histogram_logfoldChange_size_normalized_counts.pdf
chkfile histogram_logfoldChange_raw_counts.pdf

# script
cd $SCRATCH
Rscript makeplots.R
