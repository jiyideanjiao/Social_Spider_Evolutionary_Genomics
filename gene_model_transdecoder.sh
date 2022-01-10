#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=1


TransDecoder.LongOrfs -t {species_name}.fa
TransDecoder.Predict -t {species_name}.fa
