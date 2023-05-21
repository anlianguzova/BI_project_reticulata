# !/bin/bash

### INPUT ###

INDIR=/home/LVP/raw_data/rna/males/raw/ # Full path to the input directory
OUTDIR=/home/LVP/raw_data/rna/males/output/ # Full path to the output directory
SPTAG=PmPr_male # Species tag
OUTTAG=renamed_raw # Output files tag

### SOFT ###

BBTools_reformat=/home/LVP/Soft/bbmap/reformat.sh 

### MAIN ###

for dir in $(find $INDIR -mindepth 1 -type d); do
    r1="$(find $dir -type f -name '*_1.fq.gz')"
    r2="$(find $dir -type f -name '*_2.fq.gz')"
    tag=$(basename $dir)
    echo "BBtools/reformat.sh starts to work with: "
    echo "R1: $r1"
    echo "R2: $r2"
    echo "TAG: $tag"
    mkdir $OUTDIR/$tag
    cd $OUTDIR/$tag
    nohup $BBTools_reformat in=$r1 in2=$r2 out=${SPTAG}.${tag}.${OUTTAG}.R1.fq.gz out2=${SPTAG}.${tag}.${OUTTAG}$
    wait
    cd ..
done
