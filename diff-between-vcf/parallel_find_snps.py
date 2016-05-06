#!/usr/bin/env python
from multiprocessing import Pool

def getChrFromFile(vcffile):
    '''
    Reads a vcf file and returns a set containing chromosome number,
    base position and alt. allele for all SNPs identified by lines
    in VCF starting with "chr"
    '''
    snplist = []
    for line in open(vcffile, 'r'):
        if line.startswith('chr'):
            s = line.split('\t')
            chrom=s[0]
            pos=s[1]
            alt=s[4]
            l = [chrom, pos, alt]
            snplist.append(l)
    return (snplist)

# Loads control and subject files
mmr664 = getChrFromFile('MMR_664_control.raw.snps_filtered.vcf')
mmr1370 = getChrFromFile('MMR_1370_subject.raw.snps_filtered.vcf')

# Split control and subject files by chromosomes
mmr664_chr18 = [x for x in mmr664 if x[0] =="chr18"]
mmr664_chr9 = [x for x in mmr664 if x[0] =="chr9"]
mmr1370_chr18 = [x for x in mmr1370 if x[0] =="chr18"]
mmr1370_chr9 = [x for x in mmr1370 if x[0] =="chr9"]

# Creates a dictionary with key: a tuple with chr, bp 
# and alt. allele, value: full SNP line in input VCF
snpdict = {}
for line in open("MMR_1370_subject.raw.snps_filtered.vcf", 'r'):
    if line.startswith("chr"):
        spl = line.split('\t')
        tup = (spl[0], spl[1], spl[4])
        snpdict[tup] = line

# Initialize output file
f = open('parallel_differing_snps.vcf', 'w')

# Printing header lines to output file
for line in open('MMR_1370_subject.raw.snps_filtered.vcf', 'r'):
    if line.startswith("##"):
        f.write(line)


def getDiff(subject, control):
    '''
    Return differences between two list of snps from 
    subject and control sample
    '''
    sub = set(tuple(lst) for lst in subject)
    ctr = set(tuple(lst) for lst in control)
    diff = sub.difference(ctr)
    return(diff)

# Running getDiff in parallel with two processes
with Pool(2) as p:
    l = p.starmap(getDiff,[(mmr1370_chr18, mmr664_chr18),(mmr1370_chr9, mmr664_chr9)])
    for diff in l:
        for d in diff:
            f.write(snpdict[d])

# Output info
print("Output VCF written to: parallel_differing_snps.vcf")
