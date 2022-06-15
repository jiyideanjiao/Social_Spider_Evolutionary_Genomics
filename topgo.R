library(topGO)
setwd("path to file")

gene.BPGO.list=read.csv("{go_annotation.csv}")
gene.BPGO=strsplit(gene.BPGO.list$go_id,",")
names(gene.BPGO)=gene.BPGO.list$OGG_ID

geneNames=names(gene.BPGO)
gene.list=read.csv("{gene.csv}")
sig.list=subset(gene.list.gT)$OGG_ID

GOfunc <- function(myInterestingGenes){
  geneList <- factor(as.integer(geneNames %in% myInterestingGenes))
  names(geneList) <- geneNames
  GOdata <- new("topGOdata", ontology = "BP", allGenes = geneList,
                annot = annFUN.gene2GO, gene2GO = gene.BPGO, nodeSize=10)
  resultFisher <- runTest(GOdata, algorithm = "classic", statistic = "fisher")
  tab <- GenTable(GOdata,resultFisher, topNodes = 500,numChar=500)
  sig.tab=subset(tab,as.numeric(result1)<0.05)
  return(sig.tab)
}

GOfunc(sig.list)

gene_result=GOfunc(sig.list)
write.csv(gene_result, file = "{output_enriched_GO.csv}")
