#!/bin/bash

# INPUT: #

FASTA=/home/LVP/assembly/ganglia_ref_trinity_please/filtred.fasta
TAG=Pdum_new_ref_trinity.cdhit_c95
OUTDIR=/home/LVP/assembly/trinity_cdhit_95_200

# SOFT: #

source activate /home/LVP/Soft/exit/envs/cdhit_env

# MAIN: #

cd $OUTDIR

echo "***** CDHIT began to work with params: *****"
echo "FASTA: $FASTA"
echo "TAG: $TAG"
echo "OUTDIR: $OUTDIR"
nohup /home/LVP/Soft/exit/envs/cdhit_env/bin/cd-hit-est -i $FASTA -o ${TAG}.fasta -c 0.95 -T 24 -d 0 -g 1 -r 1 -M 5000
wait
echo "##### Job is complete #####"
