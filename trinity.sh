#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n {number}

Trinity \
--trimmomatic \
--seqType fq \
--max_memory 20G \
--left left.fq \
--right right.fq \
--CPU {number} \
--output trinity_output \
--no_bowtie \
--quality_trimming_params "SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:70"  \
--normalize_reads \
--normalize_max_read_cov 100
