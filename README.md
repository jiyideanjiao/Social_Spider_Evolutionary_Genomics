### Genomic signatures of recent convergent transitions to social life in spiders

- Authors: Chao Tong
- Date: March-7-2021

- Project description:
- We perform this comparative genomics study to determine if there is consistent genomic signatures of protein-coding sequence evolution associated with the convergent evolution of sociality in spiders.


### Assembly and annotation

- introduction to **Trinity** [link](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
- install **Trinity** via **conda**

```
conda install -c bioconda trinity
```
- 1. *de novo* assembly with Trinity

```
sbatch trinity.sh
```
- output files: Aexl.fasta (fasta format)

- 2. remove redundance with CD-HIT [link](http://weizhongli-lab.org/cd-hit/)
```
cd-hit -i {species_name}.fa -o {species_name}_0.9.fa -c 0.9 -n 5 -M 16000 –d 0 -T 8
```
- 3. protein-coding region prediction with TransDecoder [link](https://github.com/TransDecoder/TransDecoder/wiki)
```
TransDecoder.LongOrfs -t {species_name}.fa
TransDecoder.Predict -t {species_name}.fa
```

- 4. Transcriptome assessment with BUSCO [link](https://vcru.wisc.edu/simonlab/bioinformatics/programs/busco/BUSCO_v3_userguide.pdf)
```
python scripts/run_BUSCO.py -i SEQUENCE_FILE -o OUTPUT_NAME -l LINEAGE -m tran
```

### Gene Orthology
- 1. OrthoDB [link](https://www.orthodb.org/v8/index.html)
```
snakemake --cores=1 -s snakefile_ogg
```
- 2. OrthoFinder [link](https://github.com/davidemms/OrthoFinder)

```
orthofinder -f {path}/folder
orthofinder -b {path}/folder
```

### Phylotranscriptomic Analysis

- 1. protein alignment with clustalo [link](https://www.ebi.ac.uk/Tools/msa/clustalo/)
```
clustalo -i input.fa -o output.aln --auto
```
- 2. trimmed gaps with trimAl v1.2 [link](http://trimal.cgenomics.org/getting_started_with_trimal_v1.2)
```
trimal -in input.fa -out output.fas -auto
```
- 3. Choosing the right substitution model with ModelFinder in IQ-Tree [link](http://www.iqtree.org/doc/Quickstart)
```
iqtree -s input.phy {option: model}
```

### Molecular Evolution Analysis
1. Rate of molecular evolution estimation

2. Test for selection


### RERconverge Analysis

### Molecular Convergence Analysis
