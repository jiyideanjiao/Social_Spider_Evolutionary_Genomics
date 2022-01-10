#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=15

~/redundans.py -v -i *.fastq -f contigs.fasta -o ./output -t 15 --log ./log
