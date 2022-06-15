#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=1

augustus --species=parasteatoda --codingseq=on final.fasta > gene_models_augustus.gff

#########
slurm
#########
