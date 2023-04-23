#!/bin/bash

### INPUT ###

INDIR=/home/maxnest/TEST/Input/ # Full path to the input directory
OUTDIR=/home/maxnest/TEST/Output/ # Full path to the output directory
SPTAG=Pret # Species tag
OUTTAG=renamed_raw # Output files tag

### SOFT ###

BBTools_reformat=/home/maxnest/Soft/bbmap/reformat.sh

### MAIN ###

for dir in $(find $INDIR -mindepth 1 -type d); do
    r1="$(find $dir -type f -name '*_R1_*.fastq.gz')"
    r2="$(find $dir -type f -name '*_R2_*.fastq.gz')"
    tag=$(basename $dir)
    echo "BBtools/reformat.sh starts to work with: "
    echo "R1: $r1"
    echo "R2: $r2"
    echo "TAG: $tag"
    mkdir $OUTDIR/$tag
    cd $OUTDIR/$tag
    nohup $BBTools_reformat in=$r1 in2=$r2 out=${SPTAG}.${tag}.${OUTTAG}.R1.fq.gz out2=${SPTAG}.${tag}.${OUTTAG}.R2.fq.gz trimreaddescription=t addslash=t spaceslash=f
    wait
    cd ..
done

