#!/bin/bash

nohup /home/LVP/Soft/SPAdes-3.15.4-Linux/bin/spades.py \
-1 /home/LVP/genome_assembly/genome_all_libs_fastP_output.unclass_merged.R1.fastq \
-2 /home/LVP/genome_assembly/genome_all_libs_fastP_output.unclass_merged.R2.fastq \
--mp-1 1 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-100000_1.fq \
--mp-2 1 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-100000_2.fq \
--mp-1 2 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-10000_1.fq \
--mp-2 2 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-10000_2.fq \
--mp-1 3 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-1000_1.fq \
--mp-2 3 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-1000_2.fq \
--mp-1 4 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-1500_1.fq \
--mp-2 4 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-1500_2.fq \
--mp-1 5 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-200000_1.fq \
--mp-2 5 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-200000_2.fq \
--mp-1 6 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-20000_1.fq \
--mp-2 6 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-20000_2.fq \
--mp-1 7 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-2000_1.fq \
--mp-2 7 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-2000_2.fq \
--mp-1 8 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-50000_1.fq \
--mp-2 8 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-50000_2.fq \
--mp-1 9 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-5000_1.fq \
--mp-2 9 /home/LVP/Pret_In_silico_MP2/cross-mates-2023-04-29/*mp-5000_2.fq \
--careful --threads 20 --memory 400 -o /home/golofeevad/SPAdes_genome

wait

echo "##### Job is complete #####"
