#!/bin/bash

source activate transdecoder_env

workdir=/home/LVP/transdecoder/cleaned

# INPUT: #
FASTA=/home/LVP/transdecoder/cleaned/cleaned_assembly_CDHIT.fasta.transdecoder_dir/longest_orfs.pep
TAG=pfama_pret_cleaned

# Analysis: #
cd $workdir
echo "***** HMMsearch began to search (vs PfamA) with params: *****"
echo "FASTA: $FASTA"
echo "TAG: $TAG"
nohup /home/lianguzova/mambaforge/envs/transdecoder_env/bin/hmmsearch --cpu 12 --domtblout ${TAG}_longORFs_vs_pfam.domtblout /home/LVP/Source/Pfam-A.hmm $FASTA
wait
echo "##### Job is complete #####"
