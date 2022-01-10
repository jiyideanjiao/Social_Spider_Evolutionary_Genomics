#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=1

maker
