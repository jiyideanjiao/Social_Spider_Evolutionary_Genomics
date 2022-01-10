- Genomic signatures of recent convergent transitions to social life in spiders
- Authors: Chao Tong
- Date: January-7-2022
- Project description: We perform this comparative genomics study to determine if there is consistent genomic signatures of protein-coding sequence evolution associated with the convergent evolution of sociality in spiders.

#### Assembly :: Transcriptome
##### Illumina read quality control
```
trimmomatic PE *R1_001.fastq.gz *R2_001.fastq.gz -baseout trimmed.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:35
```
##### *de novo* assembly with **Trinity** [link](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
```
conda install -c bioconda trinity
sbatch trinity.sh
```
##### *de novo* assembly with **rnaSPAdes** [link](https://cab.spbu.ru/software/rnaspades/)
```
conda install -c bioconda spades
sbatch rnaSPAdes.sh
```
##### Remove redundance with **CD-HIT** [link](http://weizhongli-lab.org/cd-hit/)
```
cd-hit -i {species_name}_assembly.fa -o {species_name}_0.9_assembly.fa -c 0.9 -n 5 -M 16000 –d 0 -T 8
```
##### Gene model prediction with **TransDecoder** [link](https://github.com/TransDecoder/TransDecoder/wiki)
```
conda install -c bioconda transdecoder
sbatch gene_model_transdecoder.sh
```
##### Gene model prediction with **Augustus** [link](https://bioinf.uni-greifswald.de/augustus/)
```
conda install -c bioconda augustus
sbatch gene_model_augustus.sh
```
##### Gene model prediction with **MAKER** [link](https://www.yandell-lab.org/software/maker.html)
```
conda install -c bioconda maker
sbatch gene_model_maker.sh
```
#### Assembly :: Genome :: Improvement
##### *de novo* assembly with **SPAdes** [link](https://github.com/ablab/spades)
```
sbatch wgs_SPAdes.sh
```
##### Remove redundance with **Redundans** [link](https://github.com/lpryszcz/redundans)
```
conda install -c genomedk redundans
sbatch redundans.sh
```
##### Improve genome with **P_RNA_scaffolder** [link](https://github.com/CAFS-bioinformatics/P_RNA_scaffolder)
```
conda install -c bioconda hisat2
sbatch mapping_RNAseq_reads.sh
sh P_RNA_scaffolder.sh -d dir -i input.sam -j spider.fa -F R1.fastq -R R2.fastq
```










##### Transcriptome assessment with **BUSCO** [link](https://vcru.wisc.edu/simonlab/bioinformatics/programs/busco/BUSCO_v3_userguide.pdf)
```
python scripts/run_BUSCO.py -i SEQUENCE_FILE -o OUTPUT_NAME -l LINEAGE -m tran
```
#### Gene Orthology
##### **OrthoDB** [link](https://www.orthodb.org/v8/index.html)
```
snakemake --cores=1 -s snakefile_ogg
```
- **OrthoFinder** [link](https://github.com/davidemms/OrthoFinder)
```
orthofinder -f {path}/folder
orthofinder -b {path}/folder
```
#### Phylotranscriptomic Analysis

- protein alignment with **clustalo** [link](https://www.ebi.ac.uk/Tools/msa/clustalo/)
```
clustalo -i input.fa -o output.aln --auto
```
- trimmed gaps with **trimAl** [link](http://trimal.cgenomics.org/getting_started_with_trimal_v1.2)
```
trimal -in input.fa -out output.fas -auto
```
- Choosing the right substitution model with **ModelFinder** in **IQ-Tree** [link](http://www.iqtree.org/doc/Quickstart)
```
iqtree -s input.phy {option: model}
```
- Tree construction with **RAxML** [link](https://cme.h-its.org/exelixis/resource/download/NewManual.pdf)
```
snakemake --cores=1 -s snakefile_raxml
```
- Species tree inferrence with **ASTRAL** [link](https://github.com/smirarab/ASTRAL)
```
java -jar astral.5.7.5.jar -i in.tree -o out.tre
```
#### Molecular Evolution Analysis
Rate of molecular evolution estimation (dN/dS)
- codon alignment construction with **PAL2NAL** [link](http://www.bork.embl.de/pal2nal/)
- input1: amino acid sequence alignment
- input2: DNA sequence
```
sbatch pal2nal.sh
```
- dN/dS estimation with **PAML** [link](http://web.mit.edu/6.891/www/lab/paml.html)
- branch-model
```
sbatch run_paml.sh
```
- Grouped dN/dS estimation (i.e. social vs. nonsocial) with **HyPHY** [link](http://www.hyphy.org/)
```
http://www.datamonkey.org/
```
Test for selection
- detecting relaxation / intensification with **RELAX** [link](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4327161/)
```
snakemake --cores=1 -s snakefile_relax
```
#### RERconverge Analysis
- download and install **RERconverge** [link](https://github.com/nclark-lab/RERconverge)
- 1. branch length estimation for each gene with **phangorn** [link](https://cran.r-project.org/web/packages/phangorn/index.html)
```
Rscript estimate_tree.R
```
- 2. run binary trait analysis
```
Rscript rerconverge.R
```
#### Gene Ontology Enrichment Analysis
- download and install **topGO** [link](https://bioconductor.org/packages/release/bioc/html/topGO.html)
- algorithm = "classic"
- statistic = "fisher"
- input file1: gene.csv
- input file2: go_annotation.csv
- output file: gene_classic_fisher_enriched_GO.csv
```
Rscript topgo.R
```
#### Molecular Convergence Analysis
- download and install **FADE** [link](https://www.datamonkey.org/fade)
```
snakemake --cores=1 -s snakefile_FADE
```
