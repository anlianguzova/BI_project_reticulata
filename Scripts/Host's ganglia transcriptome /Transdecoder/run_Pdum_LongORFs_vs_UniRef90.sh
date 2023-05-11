#!/bin/bash

source activate diamond_env

workdir=/home/LVP/transdecoder/cleaned

# INPUT: #
FASTA=/home/LVP/transdecoder/cleaned/cleaned_assembly_CDHIT.fasta.transdecoder_dir/longest_orfs.pep
DB=/home/LVP/transdecoder/uniref
TAG=Uniref_Pret_cleaned

# Analysis: #
echo "***** DIAMOND BLASTp began to search (vs UniRef90) with params: *****"
echo "FASTA: $FASTA"
echo "DB: $DB"
echo "TAG: $TAG"
nohup /home/lianguzova/mambaforge/envs/diamond_env/bin/diamond blastp --db $DB --query $FASTA --threads 12 --out ${workdir}/${TAG}_longest_orfs_vs_UniRef90.diamond.outfmt6 --outfmt 6 --max-target-seqs 1 --evalue 1e-5
wait
echo "##### Job is complete #####"
