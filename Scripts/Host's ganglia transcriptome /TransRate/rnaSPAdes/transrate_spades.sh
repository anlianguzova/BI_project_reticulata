#!/bin/bash

### INPUT ###

R1=/home/LVP/assembly/ganglia.merged.R1.fastq # Full path to the decontaminated and merged R1 fastq file
R2=/home/LVP/assembly/ganglia.merged.R2.fastq # Full path to the decontaminated and merged R2 fastq file
Contigs=/home/LVP/assembly/CDHIT_spades_cluster_95_percent/ganglia.new_ref_rnaSPAdes.cdhit_c95.fasta # Full path to the fasta file with assembled contigs (length >= 200 bp)
OUTDIR=/home/lianguzova/transrate/ganglia_rnaSPAdes_TransRate_output # Full path to the directory where the quality control results will be stored

### SOFT ##

source activate /home/lianguzova/mambaforge/envs/transrate_env # Full path to the TransRate virtual environment

TRANSRATE=/home/LVP/Soft/transrate-1.0.1/bin/transrate # Full path to TransRate software

### MAIN ###

echo "***** TransRate (v1.0.1) began to work with params: *****"
echo "R1: $R1"
echo "R2: $R2"
echo "Assembly: $Contigs"
cd $OUTDIR
nohup ${TRANSRATE} --assembly=$Contigs --left=$R1 --right=$R2 --threads=24 --output=${OUTDIR}
wait
echo "##### Job is complete #####"
