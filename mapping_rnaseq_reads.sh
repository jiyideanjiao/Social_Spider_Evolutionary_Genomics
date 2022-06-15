#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n {number}

hisat2-build spider.fasta spider_hisat
hisat2 -x spider_hisat -1 ../fastq/R1.fastq -2 ../fastq/R2.fastq -k 3 -p 20 --pen-noncansplice 1000000 -S input.sam
