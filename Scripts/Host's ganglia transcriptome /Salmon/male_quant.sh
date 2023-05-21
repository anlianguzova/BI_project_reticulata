#!/bin/bash

### INPUT: ###
tmmdir=/home/LVP/kraken2_outputs/males_kraken2_output
outdir=/home/LVP/salmon_cleaned_assembly/
index=/home/LVP/salmon_cleaned_assembly/good_Pdum_new_ref_index

### Analyses ###

cd $outdir

for dir in $(find $tmmdir -mindepth 1 -type d); do
    r1="$(find $dir -type f -name '*class.R_1.fastq')" 
    r2="$(find $dir -type f -name '*class.R_2.fastq')"
    tag=$(basename -- $dir _vs_PlusPF_db)
    echo "Salmon quant starts to work with: "
    echo "R1: $r1"
    echo "R2: $r2"
    echo "TAG: $tag"
    echo "Ref_index: $index"
 nohup salmon quant -i ${index} -l A -1 $r1 -2 $r2 -o ${tag}_quant --seqBias --gcBias --minScoreFraction 0.50 --softclip --threads 12 --validateMappings --writeUnmappedNames
    wait
done

echo "##### Job is complete =^_^= #####"

