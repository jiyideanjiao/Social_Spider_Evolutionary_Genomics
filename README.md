### Comparative Genomics of Social Spiders

- Authors: Chao Tong
- Date: Jan-28-2021

- Project description:
- We perform this comparative genomics study to determine if there is a consistent genomic signature of protein-coding sequence evolution associated with the convergent evolution of sociality in spiders.

- Code for submission:
- Genome-wide, genic, and site-specific changes associated with the convergent evolution of sociality in spiders. biorxiv, 2020 [link](https://www.biorxiv.org/content/10.1101/2021.01.27.428473v1)


### Transcriptome Assembly

- introduction to **Trinity** [link](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
- install **Trinity** via **conda**
- I love conda! :heart_eyes:

```
conda install -c bioconda trinity
```
start *de novo* assembly

```
Trinity \
--trimmomatic \
--seqType fq \
--max_memory 20G \
--left left.fq \
--right right.fq \
--CPU 20 \
--output trinity_output \
--no_bowtie \
--quality_trimming_params "SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:70"  \
--normalize_reads \
--normalize_max_read_cov 100
```
- output files: Aexl.fasta (fasta format)

### Gene Orthology

### Phylotranscriptomic Analysis

### Molecular Evolution Analysis
1. Rate of molecular evolution estimation

2. Test for selection


### RERconverge Analysis

### Molecular Convergence Analysis
