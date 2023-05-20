#!/bin/bash

# INPUT: #
R1=/home/LVP/genome_assembly/genome_all_libs_fastP_output.unclass_merged.R1.fastq # Full path to the merged decontaminated (after Kraken2) R1 fastq file
R2=/home/LVP/genome_assembly/genome_all_libs_fastP_output.unclass_merged.R2.fastq # Full path to the merged decontaminated (after Kraken2) R2 fastq file
OUTTAG=Pret.genome.unclass.k25_counts.jf # Some name of lf result file
HISTOTAG=Pret.genome.unclass.k25_counts.histo
OUTDIR=/home/LVP/genome_assembly/jellyfish_results # Full path to the directory where the jellyfish output will be stored

### SOFT ###

JELLYFISH=/home/LVP/Soft/Trinity/jellyfish-2.3.0/bin/jellyfish # Full path to the Jellyfish

### MAIN ###
echo "***** Jellyfish began to work with params: *****"
echo "R1: $R1"
echo "R2: $R2"
echo "OUTTAG: $OUTTAG"
echo "OUTDIR: $OUTDIR"

mkdir -p $OUTDIR
cd $OUTDIR

nohup $JELLYFISH count -m 25 -s 265M -t 10 -o $OUTTAG -C $R1 $R2
wait

echo "***** Histo jellyfish began to work with param: *****"
echo "HISTOTAG: $HISTOTAG"

nohup $JELLYFISH histo -t 10 $OUTTAG > $HISTOTAG
wait

echo "##### Job is complete #####"
