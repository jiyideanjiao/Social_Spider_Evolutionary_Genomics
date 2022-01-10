#!/bin/bash -ve
#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH --cpus-per-task=1

busco -i {genome assembly} \
        -l arachnida_odb10 \
        -o busco \
        -m genome \
        --cpu 10


busco -i {transcriptome assembly} \
        -l arachnida_odb10 \
        -o busco \
        -m trans \
        --cpu 10

busco -i {genome assembly} \
        -l arthropoda_odb10 \
        -o busco \
        -m genome \
        --cpu 10

busco -i {transcriptome assembly} \
        -l arthropoda_odb10 \
        -o busco \
        -m trans \
        --cpu 10
