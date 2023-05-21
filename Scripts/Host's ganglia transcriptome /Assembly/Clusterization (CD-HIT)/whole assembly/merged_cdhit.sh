#!/bin/bash

# INPUT: #

FASTA=/home/LVP/assembly/whole_assembly.fasta
TAG=whole_assembly_CDHIT
OUTDIR=/home/LVP/assembly/CDHIT_whole_cluster_95_percent

# SOFT: #

source activate /home/lianguzova/mambaforge/envs/cdhit_env

# MAIN: #

mkdir $OUTDIR
cd $OUTDIR

echo "***** CDHIT began to work with params: *****"
echo "FASTA: $FASTA"
echo "TAG: $TAG"
echo "OUTDIR: $OUTDIR"
nohup /home/lianguzova/mambaforge/envs/cdhit_env/bin/cd-hit-est -i $FASTA -o ${TAG}.fasta -c 0.95 -T 24 -d 0 -g 1 -r 1 -M 5000
wait
echo "##### Job is complete #####"
