#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n {number}


TransDecoder.LongOrfs -t {species_name}.fa
TransDecoder.Predict -t {species_name}.fa
