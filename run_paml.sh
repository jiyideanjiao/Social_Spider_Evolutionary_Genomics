#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n {number}

for i in `ls *.phy`
do
id=$(basename $i .phy)
python autoPAML.py $i phylogeny_24.tre $id.out
done;
