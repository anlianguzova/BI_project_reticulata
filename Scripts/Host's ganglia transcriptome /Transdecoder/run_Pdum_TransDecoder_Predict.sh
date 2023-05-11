#!/bin/bash

source activate transdecoder_env

workdir=/home/LVP/transdecoder/cleaned/

cd $workdir

# INPUT: #
FASTA=/home/LVP/assembly/CDHIT_cleaned_cluster_95_percent/cleaned_assembly_CDHIT.fasta  
PFAM=/home/LVP/transdecoder/cleaned/pfama_pret_cleaned_longORFs_vs_pfam.domtblout
BLASTP=/home/LVP/transdecoder/cleaned/Uniref_Pret_cleaned_longest_orfs_vs_UniRef90.diamond.outfmt6

# Analysis: #
echo "***** TransDecoder.Predict began to work with params: *****"
echo "FASTA: $FASTA"
echo "PFAM: $PFAM"
echo "BLASTP: $BLASTP"
nohup /home/lianguzova/mambaforge/envs/transdecoder_env/bin/TransDecoder.Predict -t $FASTA --retain_pfam_hits $PFAM --retain_blastp_hits $BLASTP
wait
echo "##### Job is complete #####"
