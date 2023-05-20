#!/bin/bash

### Input ###

FASTPDIR=/home/LVP/fastp/rna/males/ # Full path to the directory where the fastP results are stored
OUTDIR=/home/LVP/kraken2_outputs/males_kraken2_output/ # Full path to the directory where the classification results (Kraken2 output) will be stored
DBDIR=/home/LVP/kraken2_db_females # Full path to the directory where the database is stored
DBTAG=Kraken2_plus_db_TEST # Some name of the database that will be used
SUFFIX=#

### SOFT ###

KRAKEN2DIR=/home/LVP/Soft/kraken2 # Full path to the directory where the Kraken2 executable files are stored

### Processing ###

mkdir -p $OUTDIR
cd $OUTDIR

for dir in $(find $FASTPDIR -mindepth 1 -type d); do
        r1="$(find $dir -type f -name '*fastp_tmm.R1.fastq.gz')"
        r2="$(find $dir -type f -name '*fastp_tmm.R2.fastq.gz')"
        tag=$(basename $dir)
        echo "Kraken2 starts to work with: "
        echo "R1: $r1"
        echo "R2: $r2"
        echo "TAG: $tag"
	mkdir ${tag}_vs_${DBTAG}
	cd ${tag}_vs_${DBTAG}
        nohup $KRAKEN2DIR/kraken2 --db ${DBDIR}/${DBTAG}/ --threads 12 --paired --gzip-compressed --unclassified-out ${tag}.unclass.R${SUFFIX}.fastq --classified-out ${tag}.class.R${SUFFIX}.fastq --output ${tag}_vs_${DBTAG}.tab --report ${tag}_vs_${DBTAG}.report ${r1} ${r2}
	cd ..
        wait
done

echo "##### Job is complete #####"

