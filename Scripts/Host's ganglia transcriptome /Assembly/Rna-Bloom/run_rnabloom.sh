#!/bin/bash

### INPUT ###

R1=/home/LVP/assembly/ganglia.merged.R1.fastq  # Full path to the merged decontaminated (after Kraken2) R1 fastq file
R2=/home/LVP/assembly/ganglia.merged.R2.fastq  # Full path to the merged decontaminated (after Kraken2) R2 fastq file
OUTTAG=ganglia_ref_rnabloom # Some name of the assembly. For example, Pret_ref_rnabloom
OUTDIR=/home/LVP/assembly/ganglia_ref_rnabloom # Full path to the directory where the assembling output will be stored

### SOFT ###

RNABLOOM=/home/lianguzova/mambaforge/bin/rnabloom # Full path to the RNA-Bloom

### MAIN ###
echo "***** RNA-Bloom began to work with params: *****"
echo "R1: $R1"
echo "R2: $R2"
echo "OUTTAG: $OUTTAG"
echo "OUTDIR: $OUTDIR"

mkdir $OUTDIR
nohup $RNABLOOM --left $R1 --right $R2 --revcomp-right --name $OUTTAG --threads 24 --outdir $OUTDIR --kmer 25 --memory 100 --percent 0.90 -length 200
wait
echo "##### Job is complete #####"

