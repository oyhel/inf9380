#!/bin/bash
#SBATCH --job-name=as_sortbedgraph
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

time arrayrun 1-4 arrw_sortbedgraph.slurm

