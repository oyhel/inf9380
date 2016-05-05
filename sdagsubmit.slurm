#!/bin/bash
#SBATCH --job-name=sdagwf
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load sdag

sdag sdagworkflow.sdag
