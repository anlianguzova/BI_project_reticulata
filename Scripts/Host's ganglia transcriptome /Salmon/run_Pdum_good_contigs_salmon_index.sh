#!/bin/bash

workdir=/home/LVP/salmon_cleaned_assembly

cd $workdir

# INPUT: #
FASTA=/home/LVP/assembly/cleaned/cleaned_assembly.fasta
TAG=good_Pdum_new_ref_index

echo "***** Salmon (index) began to work with params: *****"
echo "FASTA: $FASTA"
echo "TAG: $TAG"
nohup salmon index --transcripts ${FASTA} --kmerLen 25 --index ${TAG} --threads 10
wait
echo "##### Job is complete #####"

