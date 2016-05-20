#!/usr/bin/env bash

runpar() {
	mpirun -np $1 pmap_dist . . data/N1_CHIP.fastq -i data/ saci >/dev/null 2>&1
	mpirun -np $1 pmap -i data/ saci . . bowtie -S -v 2 -m 1 >/dev/null 2>&1
	awk 'NR <= 3 || !/^@/' < out.txt > N1_CHIP.sam
}


for proc in $(seq 1 20); do
        echo "processes: " $proc
	time -p runpar $proc
done
