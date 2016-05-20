#!/bin/bash
#SBATCH --job-name=s_peakcalling
#SBATCH --account=ln0002k
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=01:00:00

source /cluster/bin/jobsetup

module purge
module load macs

# Input: sam file for the case sample
input_case=$1
# Input: sam file for the control sample
input_control=$2
# Input: prefix of the output file, output is <prefix>_peaks.bed
project_prefix=$3

cp $input_case $SCRATCH
cp $input_control $SCRATCH

chkfile ${project_prefix}_peaks.bed

# script
cd $SCRATCH

time macs14 -t $input_case -c $input_control -n $project_prefix -g 2.23e6 -f SAM
