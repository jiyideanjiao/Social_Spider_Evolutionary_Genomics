#!/bin/bash -ve
#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=20

~/spades.py --rna -1 trimmed_1P.fastq -2 trimmed_2P.fastq -t 20 -o output_dir
