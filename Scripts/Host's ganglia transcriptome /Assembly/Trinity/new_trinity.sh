#!/bin/bash

# INPUT: #
R1=/home/LVP/assembly/ganglia.merged.R1.fastq # Full path to the merged decontaminated (after Kraken2) R1 fastq file
R2=/home/LVP/assembly/ganglia.merged.R2.fastq # Full path to the merged decontaminated (after Kraken2) R2 fastq file
OUTTAG=trinity_ass # Some name of the assembly. For example, Pret_ref_Trinity
OUTDIR=/home/LVP/assembly/ganglia_ref_trinity_please  # Full path to the directory where the assembling output will be stored

### SOFT ###

TRINITY=/home/LVP/Soft/trinityrnaseq-v2.14.0/Trinity # Full path to the Trinity

### MAIN ###
echo "***** Trinity began to work with params: *****"
echo "R1: $R1"
echo "R2: $R2"
echo "OUTTAG: $OUTTAG"
echo "OUTDIR: $OUTDIR"

source activate /home/LVP/Soft/exit/envs/trinity_env # conda env

cd $OUTDIR

nohup $TRINITY --seqType fq --max_memory 100G --left $R1 --right $R2 --SS_lib_type FR --CPU 24 --min_contig_length 200 --output $OUTTAG --full_cleanup
wait
echo "##### Job is complete #####"
