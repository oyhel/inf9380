#!/bin/bash

module load bowtie

cp -r /work/projects/norbis/workflows/chip/data/ .
cp -r /work/projects/norbis/workflows/chip/programs .
chmod a+rx programs/*
bowtie-build -f data/saci.fasta data/saci
