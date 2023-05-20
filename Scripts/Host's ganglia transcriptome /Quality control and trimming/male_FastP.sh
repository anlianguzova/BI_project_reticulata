#!/bin/bash

### INPUT ###

INDIR=/home/LVP/raw_data/rna/males/output # Full path to the input directory
OUTDIR=/home/LVP/raw_data/rna/males/fastp_output # Full path to the output directory

### Soft ###

fastp=/home/LVP/Soft/fastp

### PARAMS ###

WIN_SIZE=4
QUAL_QUAL=20
MEAN_QUAL=20
MIN_LEN=25
THREADS=5

### MAIN ###

cd $OUTDIR

for dir in $(find $INDIR -mindepth 1 -type d); do
    r1="$(find $dir -type f -name '*1.fq.gz')"
    r2="$(find $dir -type f -name '*2.fq.gz')"
    tag=$(basename $dir)
    echo "FastP starts to work with: "
    echo "R1: $r1"
    echo "R2: $r2"
    echo "TAG: $tag"
    echo "Window size: $WIN_SIZE"
    echo "Mean quality: $MEAN_QUAL"
    echo "Qualified quality: $QUAL_QUAL"
    echo "Min length: $MIN_LEN"
    echo "Threads: $THREADS"
    mkdir ${tag}_fastP_output
    cd ${tag}_fastP_output
    nohup $fastp --in1 $r1 --out1 ${tag}.fastp_tmm.R1.fastq.gz --in2 $r2 --out2 ${tag}.fastp_tmm.R2.fastq.gz --unpaired1 ${tag}.fastp_unpaired1.fastq.gz --unpaired2 ${tag}.fastp_unpaired2.fastq.gz --failed_out ${tag}.fastp_failed_out.fastq.gz --cut_right --cut_window_size $WIN_SIZE --cut_mean_quality $MEAN_QUAL --qualified_quality_phred $QUAL_QUAL --length_required $MIN_LEN --html ${tag}.fastp_report.html --json ${tag}.fastp_report.json --thread $THREADS
    wait
    cd ..
done

echo "##### Job is complete #####"
