### Genomic signatures of recent convergent transitions to social life in spiders

- Authors: Chao Tong
- Date: March-7-2021

- Project description:
- We perform this comparative genomics study to determine if there is consistent genomic signatures of protein-coding sequence evolution associated with the convergent evolution of sociality in spiders.


### Assembly and Annotation

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
- 3. choosing the right substitution model with ModelFinder in IQ-Tree [link](http://www.iqtree.org/doc/Quickstart)
```
iqtree -s input.phy {option: model}
```
- 4. tree construction with RAxML [link](https://cme.h-its.org/exelixis/resource/download/NewManual.pdf)
```
snakemake --cores=1 -s snakefile_raxml
```
- 5. species tree inferrence with ASTRAL [link](https://github.com/smirarab/ASTRAL)
```
java -jar astral.5.7.5.jar -i in.tree -o out.tre
```

### Molecular Evolution Analysis
1. Rate of molecular evolution estimation (dN/dS)
- 1. codon alignment construction with PAL2NAL [link](http://www.bork.embl.de/pal2nal/)
- input1: amino acid sequence alignment
- input2: DNA sequence
```
sbatch pal2nal.sh
```
- 2. dN/dS estimation with PAML [link](http://web.mit.edu/6.891/www/lab/paml.html)
- branch-model
```
sbatch run_paml.sh
```
- 3. grouped dN/dS estimation (i.e. social vs. nonsocial) with HyPHY [link](http://www.hyphy.org/)
```
http://www.datamonkey.org/
```
2. Test for selection
- detecting relaxation / intensification with RELAX [link](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4327161/)
```
snakemake --cores=1 -s snakefile_relax
```

### RERconverge Analysis

### Molecular Convergence Analysis
