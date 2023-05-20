#!/bin/bash

### INPUT ###

OUTDIR=/home/LVP/Kraken2_DB_reticulata/ # Full path to the directory where the database will be stored
DBTAG=Kraken2_plus_db_TEST # Some name of the database to be created

### SOFT ###

KRAKEN2DIR=/home/LVP/Soft/kraken2 # Full path to the directory where the Kraken2 executable files are stored

### Processing ###

cd $OUTDIR

nohup $KRAKEN2DIR/kraken2-build --build --db $DBTAG --threads 12
wait

echo "##### Job is complete #####"

