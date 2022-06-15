
#install.packages("remotes")
#library(remotes)
#remotes::install_github("nclark-lab/RERconverge")

library(RERconverge)
library(topGO)
source("Permulationfun.R")

setwd("")
#setwd("")

spidertreefile = "branch_length_spider25.txt"
spidertrees = readTrees(spidertreefile, max.read = 7540)

spidernames <- c("r1","r2","r3","r4","r5","r6","r7","r8","Smim","Sdum","r20","r21","r12","r13","r14","r15","r16","r22","r23","r17","r18","r19","r24","r25","Agen")
spiderRER = getAllResiduals(spidertrees, useSpecies = spidernames, transform = "sqrt", weighted = T, scale = T, min.sp = 3)

#saveRDS(spiderRER, file = "spiderRER.rds")
#newspiderRER =  readRDS("spiderRER.rds")
#multirers = returnRersAsTreesAll(spidertrees,spiderRER)
#write.tree(multirers, file='spiderRER.nwk', tree.names=TRUE)

#generate a binary tree from a vector of foreground species using foreground2Tree
social.foreground = c("r1","r2","r4","r5","r6","Smim","Sdum","r12","r17")
sisters.social=list("clade1"=c("r1","r2"))
social.Fg.tree = foreground2TreeClades(social.foreground, sisters.social, spidertrees,plotTree=F)

phenvsocial=tree2PathsClades(social.Fg.tree, spidertrees)

#min.sp: the minimum number of species in the gene tree for that gene to be included in the analysis.
#The default is "10", but you may wish to modify it depending upon the number of species in your mastertree.
#min.pos: the minimum number of independent foreground (non-zero) lineages represented in the gene tree
#for that gene to be included in the analysis. The default is 2, requiring at least two foreground
#lineages to be present in the gene tree.
corsocial=correlateWithBinaryPhenotype(spiderRER, phenvsocial, min.sp=3, min.pos=2,weighted="auto")

#head(corsocial[order(corsocial$P),])
#write.csv((corsocial[order(corsocial$P),]), file = "RER_spider_N24_7539_OGG_Phangorn.csv")


#creating a gene2GO list from the list of 7590 shared orthologs, where there is a gene name and list of GO terms
gene.BPGO.list=read.csv("go_annotation.csv")
gene.BPGO=strsplit(gene.BPGO.list$go_id,",")
names(gene.BPGO)=gene.BPGO.list$OGG_ID
GO2geneID=inverseList(gene.BPGO)

annot=list("GO"=list("genesets"=GO2geneID,"geneset.names"=names(GO2geneID)))


#getStat converts correlation results to Rho-signed negative log p-values, removes NA values, and returns a named numeric vector, with names 
#corresponding to rownames of correlation results (i.e. gene names)
#[ see https://cdn.rawgit.com/nclark-lab/RERconverge/master/vignettes/FullWalkthroughUTD.html  "Deriving a ranked gene list" ]
stats=getStat(corsocial)

enrichment=fastwilcoxGMTall(stats, annot, outputGeneVals=T, num.g=10)


root_sp = "Agen"
masterTree = spidertrees$masterTree


perms = getPermsBinary(numperms=10000, fg_vec=social.foreground, sisters_list=sisters.social, root_sp=root_sp, 
                       RERmat=spiderRER, trees=spidertrees,mastertree=masterTree,permmode="cc",
                       min.pos=2,calculateenrich=T,annotlist=annot)



corpermpvals=permpvalcor(corsocial,perms)
enrichpermpvals=RERconverge::permpvalenrich(enrichment, perms)

res=corsocial

# add permulations to real results
res$permpval=corpermpvals[match(rownames(res), names(corpermpvals))]
res$permpvaladj=p.adjust(res$permpval, method="BH")
count=1
while(count<=length(enrichment)){
  enrichment[[count]]$permpval=enrichpermpvals[[count]][match(rownames(enrichment[[count]]),
                                                              names(enrichpermpvals[[count]]))]
  enrichment[[count]]$permpvaladj=p.adjust(enrichment[[count]]$permpval, method="BH")
  count=count+1
}

write.csv(res, file = "gene_RER_output.csv")
write.csv(enrichment, file = "GO_RER_output.csv")


#plot correlations and check Spearman rank correlations between p.adj and perm p, etc.
#plot(enrichment$GO$permpval,enrichment$GO$p.adj)
#plot(res$p.adj,res$permpval)

#cor.test(res$P,res$permpval,test="spearman")
#cor.test(res$p.adj,res$permpval,test="spearman")
#cor.test(enrichment$GO$permpval,enrichment$GO$pval,test="spearman")
#cor.test(enrichment$GO$permpval,enrichment$GO$p.adj,test="spearman")
