#!/bin/bash

### INPUT ###

OUTDIR=/home/LVP/Kraken2_DB_reticulata/ # Full path to the directory where the database will be stored
DBTAG=Kraken2_plus_db_reticulata # Some name of the database to be created

### SOFT ###

KRAKEN2DIR=/home/LVP/Soft/kraken2 # Full path to the directory where the Kraken2 executable files are stored

### Processing ###

mkdir -p $OUTDIR
cd $OUTDIR

nohup $KRAKEN2DIR/kraken2-build --download-taxonomy --db $DBTAG --threads 5 --use-ftp
wait
nohup $KRAKEN2DIR/kraken2-build --download-library archaea --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library viral --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library bacteria --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library plasmid --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library human --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library fungi --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library protozoa --db $DBTAG --threads 5
wait
nohup $KRAKEN2DIR/kraken2-build --download-library UniVec_Core --db $DBTAG --threads 5
wait

echo "##### Job is complete #####"
