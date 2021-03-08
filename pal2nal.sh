#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=1

for i in `ls *.aln`
do
id=$(basename $i .aln)
perl pal2nal.pl $i $id.fa -output fasta -nogap > $id.fas
done;
