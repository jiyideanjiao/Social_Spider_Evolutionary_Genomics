#!/usr/local/bin/python
##File takes in the name of an OGG from OrthoDB7
##Finds all sequences for all ant species, uses MAFFT, PRANK, and HMMER to make markov models of OGGs

import numpy as np, sys, getopt, pandas as pd
from subprocess import call
import subprocess
from joblib import Parallel, delayed
import re

def InOut(argv):
	inputfile=''
	outputfile = ''
	try:
	        opts, args = getopt.getopt(argv,"h:t:s:",["tfile=","sfile="])
	except getopt.GetoptError:
	        print 'OGGalign.py -t <threads> -s <seqfile>'
	        sys.exit(2)
	for opt, arg in opts:
	        if opt in ("-t","--tfile"):
	                num_cores = arg 
	        elif opt in ("-s","--sfile"):
	                seqfile = arg                    
	return num_cores,seqfile

def alignGene(OGG,data):
	call(["prank","-d="+OGG+".fa","-o="+OGG])
	call(["mv",OGG+".best.fas",OGG+".fas"])
	call(["convbioseq","stockholm",OGG+".fas"])
	call(["hmmbuild",OGG+".hmm",OGG+".sth"])
	call(["rm",OGG+".fa",OGG+".sth",OGG+".fas"])
	return

def main(argv):
	num_cores,seqfile = InOut(argv)
	df = pd.read_csv(seqfile,sep="\t")
	data = np.array(df)
	OGGS = np.unique(data[:,1])
	for OGG in OGGS:
		Parallel(n_jobs=int(num_cores))(delayed(alignGene)(OGG,data)for OGG in OGGS)

if __name__ == "__main__":
	main(sys.argv[1:])
