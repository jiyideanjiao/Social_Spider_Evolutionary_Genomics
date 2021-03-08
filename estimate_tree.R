require(phangorn)
require(tools)
setwd("")

pruneAlnFromTree = function(alnfile, treefile, type = "AA", format = "fasta", writealn=TRUE)
{
  #prune the alignment to have only the species in the tree
  #read in the alignment
  alnPhyDat = read.phyDat(alnfile, type = type, format = format)
  #read in the treefile
  genetree = read.tree(treefile)
  #eliminate species in the alignment but not the tree
  inboth = intersect(names(alnPhyDat),genetree$tip.label)
  alnPhyDat = subset(alnPhyDat, subset = inboth)
  if (writealn) {
    #write the new alignment with a revised filename
    fe = file_ext(alnfile)
    fpse = file_path_sans_ext(alnfile)
    write.phyDat(alnPhyDat, file=paste(fpse,".pruned.",fe,sep=""), format = format)
  }
  return(alnPhyDat)
}


pruneTreeFromAln = function (treefile, alnfile, type = "AA", format = "fasta", writetree=TRUE)
{
  #prune the tree to have only the species in the alignment
  #read in the alignment
  alnPhyDat = read.phyDat(alnfile, type = type, format = format)
  #read in the treefile
  genetree = read.tree(treefile)
  #eliminate species in the alignment but not the tree and vice versa
  inboth = intersect(names(alnPhyDat),genetree$tip.label)
  todrop = genetree$tip.label[genetree$tip.label %in% inboth == FALSE]
  if (length(todrop) > 0) {
    genetree = drop.tip(genetree, todrop)
  }
  #unroot the tree
  genetree = unroot(genetree)
  if (writetree) {
    #write the new tree with a revised filename
    fe = file_ext(treefile)
    fpse = file_path_sans_ext(treefile)
    write.tree(genetree, file=paste(fpse,".pruned.",fe,sep=""))
  }
  return(genetree)
}

estimatePhangornTree = function(alnfile, treefile, submodel="LG", type = "AA",
                                format = "fasta", k=4, ...)
{
  alnPhyDat = read.phyDat(alnfile, type = type, format = format)
  genetree = read.tree(treefile)
  inboth = intersect(names(alnPhyDat),genetree$tip.label)
  todropg = genetree$tip.label[genetree$tip.label %in% inboth == FALSE]
  if (length(todropg) > 0) {
    genetree = drop.tip(genetree, todropg)
  }
  if (length(inboth) < length(names(alnPhyDat))) {
    alnPhyDat = subset(alnPhyDat, subset = inboth)
  }
  genetree = unroot(genetree)
  genetree$edge.length = c(rep(1,length(genetree$edge.length)))
  lgptree = pml(genetree, alnPhyDat, model = submodel, k = k, rearrangement="none", ...)
  lgopttree = optim.pml(lgptree,optInv=T,optGamma=T,optEdge=T,rearrangement="none",
                        model=submodel, ...)
  return(list("results.init"=lgptree,"results.opt"=lgopttree, "tree.opt"=lgopttree$tree))
}

estimatePhangornTreeAll = function(alnfiles=NULL, alndir=NULL, pattern=NULL, treefile, output.file=NULL,
                                   submodel="LG", type = "AA", format = "fasta", k=4, ...)
{
  if(is.null(output.file)){
    stop("output.file must be supplied")
  }
  if (is.null(alnfiles)&&is.null(alndir)){
    stop("Either alnfiles or alndir must be supplied")
  }

  if (!is.null(alnfiles)&&!is.null(alndir)){
    stop("Only one of alnfiles or alndir must be supplied")
  }

  if (!is.null(alndir)){
    alnfiles=list.files(path=alndir, pattern=pattern, full.names = TRUE)
  }
  names=basename(alnfiles)
  names=sub("\\.\\w*$", "", names)

  treesL=vector(mode = "list", length = length(names))
  for(i in 1:length(alnfiles)){
   message(paste("Processing", alnfiles[i]))
 tree.res=estimatePhangornTree(alnfiles[i], treefile, submodel=submodel, type = type,
                                          format = format, k=k, ...)
   treesL[[i]]=tree.res$tree
  }
  fc=file(output.file, "wt")
  for(i in 1:length(alnfiles)){
  writeLines(paste(names[i], write.tree(treesL[[i]]), sep = "\t"), fc)
  }
  close(fc)
}

estimatePhangornTreeAll(treefile="phylogeny_spider25.txt",alndir="/",output.file="output.tre",pattern="*.pruned.fas")
