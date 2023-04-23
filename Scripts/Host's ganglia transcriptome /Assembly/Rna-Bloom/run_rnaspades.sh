#!/bin/bash

### INPUT ###
R1=/home/LVP/assembly/ganglia.merged.R1.fastq # Full path to the merged decontaminated (after Kraken2) R1 fastq file
R2=/home/LVP/assembly/ganglia.merged.R2.fastq # Full path to the merged decontaminated (after Kraken2) R2 fastq file
OUTDIR=/home/LVP/assembly/ganglia_ref_rnaSPAdes # Full path to the directory where the assembling output will be stored

### SOFT ###

SPADES=/home/LVP/Soft/SPAdes-3.15.4-Linux/bin/rnaspades.py

### MAIN ###
echo "***** rnaSPAdes began to work with params: *****"
echo "R1: $R1"
echo "R2: $R2"
echo "OUTDIR: $OUTDIR"
mkdir $OUTDIR
nohup $SPADES -1 $R1 -2 $R2 --ss fr --threads 24 --memory 100 -o $OUTDIR
wait
echo "##### Job is complete #####"

