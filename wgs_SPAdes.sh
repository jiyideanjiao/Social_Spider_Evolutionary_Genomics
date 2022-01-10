#!/bin/bash -ve
#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n 20

~/spades.py \
--pe1-1 trimmed_1P.fastq \
--pe1-2 trimmed_2P.fastq \
-k 13,15,17,19,23,33,43,53,63,73,83,93,103 \
-t 20 \
-o output_genome
