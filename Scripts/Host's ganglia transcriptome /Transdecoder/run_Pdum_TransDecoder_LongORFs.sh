#!/bin/bash

source activate transdecoder_env

workdir=/home/LVP/transdecoder/cleaned/again

cd $workdir

# INPUT: #
FASTA=/home/LVP/assembly/CDHIT_cleaned_cluster_95_percent/cleaned_assembly_CDHIT.fasta  

# Analysis: #
echo "***** TransDecoder.LongORFs began to work with params: *****"
echo "FASTA: $FASTA"
nohup /home/lianguzova/mambaforge/envs/transdecoder_env/bin/TransDecoder.LongOrfs -t $FASTA -m 100 -G universal
wait
echo "##### Job is complete #####"
