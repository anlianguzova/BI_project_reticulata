#!/bin/bash

source activate busco_env

workdir=/home/LVP/busco/

cd $workdir

# INPUT: #
Contigs=/home/LVP/assembly/QC/trinity_TransRate_output/good.Pdum_new_ref_trinity.cdhit_c95.fasta
TAG=good_Pret_new_ref_trinity_vs_Metazoa_odb10
DB=/home/LVP/Source/BUSCO/metazoa_odb10

# Analysis: #
echo "***** BUSCO began to work with params: *****"
echo "DB: $DB"
echo "TAG: $TAG"
echo "Assembly: $Contigs"
nohup /home/lianguzova/mambaforge/envs/busco_env/bin/busco -m transcriptome -i $Contigs -o $TAG -l $DB --cpu 12
wait
echo "##### Job is complete #####"
