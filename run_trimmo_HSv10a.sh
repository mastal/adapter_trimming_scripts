#!/bin/bash

# Maria Stalteri
# 23/09/2013
# run_trimmo_HSv10a.sh

# v10a: 
# palindrome plus simple clipping plus quality trimming;
# uses HiSeq_adapters_trimmo_short_v4.fasta

# have changed the IlluminaClip score to 12 for simple clipping;

# first time doing both adapter clipping and quality clipping;
# going for relatively high quality trimming, but not XT

java -jar /usr/local/src/Trimmomatic/Trimmomatic-0.30/trimmomatic-0.30.jar \
PE  \
-threads 8  \
-phred33  \
-trimlog /df/maria_assemc/trim_HS_LIB955/trim_LIB955_v10a.log \
/df/maria_assemc/HS_Sample_LIB955/LIB955_ACTTGA_L002_R1.fastq \
/df/maria_assemc/HS_Sample_LIB955/LIB955_ACTTGA_L002_R2.fastq \
/df/maria_assemc/trim_HS_LIB955/LIB955_R1_trimv10a_paired.fastq \
/df/maria_assemc/trim_HS_LIB955/LIB955_R1_trimv10a_unp.fastq \
/df/maria_assemc/trim_HS_LIB955/LIB955_R2_trimv10a_paired.fastq \
/df/maria_assemc/trim_HS_LIB955/LIB955_R2_trimv10a_unp.fastq \
ILLUMINACLIP:/dc/maria_trimmo/adapters/HiSeq_adapters_trimmo_short_v4.fasta:2:15:12 \
CROP:99 TRAILING:3 LEADING:3 SLIDINGWINDOW:4:25 MINLEN:50

