#!/usr/local/bin/python
#File takes in a fasta file containing protein sequences from many species
#The protein sequences are labeled by their unique OrthoDB8 key. 
#The purpose is to replace the key with >Ortholog|species|gene name
from Bio import SeqIO
import sys, getopt, re

def InOut(argv):
	inputfile=''
	outputfile = ''
	try:
	        opts, args = getopt.getopt(argv,"hi:o:s:",["ifile=","ofile=","sfile="])
	except getopt.GetoptError:
	        print 'FastaHeaderOGG.py -i <inputfile> -o <outputfile> -s <seqfile>'
	        sys.exit(2)
	for opt, arg in opts:
	        if opt in ("-i","--ifile"):
	                inputfile = arg
	        elif opt in ("-o","--ofile"):
	                outputfile = arg   
	        elif opt in ("-s","--sfile"):
	                seqfile = arg                    
	return inputfile,outputfile,seqfile


def main(argv):
	inputfile,outputfile,seqfile = InOut(argv)
	OGGdict = {} #create dictionary to store genes with the new ID names
	with open(seqfile,'r') as f:
		f.readline() #skip header line
		for line in f:
			l = line[:-1]
			#The line below parses the line from the OrthoDB file and returns the new header
			newl = re.sub(r'.*\t([A-Z0-9]+)\t([A-Za-z]*).*\t([0-9]+:[0-9a-zA-Z]+).*',r'\g<1>|\g<2>|\g<3>',l)
			gene = re.sub(r'.*\|.*\|([0-9]+:[0-9a-zA-Z]+).*',r'\g<1>',newl)
			OGGdict[gene]=newl
	newfasta= open(outputfile, 'w')
	with open(inputfile,'r') as f:
		for line in f:
			if line.startswith('>'):
				gene = re.findall('>[0-9]+:[0-9a-zA-Z]+',line) ###Fix to find the gene (number code)
				gene = gene[0][1:] #convert from list, strip ">"
				newfasta.write(">"+OGGdict[gene]+"\n")
			else:
				newfasta.write(line)
	newfasta.close()


if __name__ == "__main__":
	main(sys.argv[1:]) 

