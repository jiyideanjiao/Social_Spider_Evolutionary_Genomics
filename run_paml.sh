#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=2

for i in `ls *.phy`
do
id=$(basename $i .phy)
python autoPAML.py $i phylogeny_24.tre $id.out
done;
