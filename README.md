### Genomic signatures of recent convergent transitions to social life in spiders

- Authors: Chao Tong
- Date: March-7-2021

- Project description:
- We perform this comparative genomics study to determine if there is consistent genomic signatures of protein-coding sequence evolution associated with the convergent evolution of sociality in spiders.


### Transcriptome Assembly

- introduction to **Trinity** [link](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
- install **Trinity** via **conda**

```
conda install -c bioconda trinity
```
- start *de novo* assembly

```
sbatch trinity.sh
```
- output files: Aexl.fasta (fasta format)

### Gene Orthology
- 1. OrthoDB [link](https://www.orthodb.org/v8/index.html)
```
snakemake --cores=1 -s snakefile_ogg
```
- 2. OrthoFinder [link](https://github.com/davidemms/OrthoFinder)

### Phylotranscriptomic Analysis

### Molecular Evolution Analysis
1. Rate of molecular evolution estimation

2. Test for selection


### RERconverge Analysis

### Molecular Convergence Analysis
