#!/usr/bin/env python

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
    snpSet = set(tuple(lst) for lst in snplist)
    return(snpSet)

# Loads control and subject files
mmr664 = getChrFromFile('MMR_664_control.raw.snps_filtered.vcf')
mmr1370 = getChrFromFile('MMR_1370_subject.raw.snps_filtered.vcf')

# Find differing SNPs between control and subject
diff = mmr1370.difference(mmr664)

# Printing header lines to output file
f = open('serial_differing_snps.vcf', 'w')
for line in open('MMR_1370_subject.raw.snps_filtered.vcf', 'r'):
    if line.startswith("##"):
        f.write(line)

# Creates a dictionary with a tuple key containing chr, bp 
# and alt. allele.
snpdict = {}
for line in open("MMR_1370_subject.raw.snps_filtered.vcf", 'r'):
    if line.startswith("chr"):
        spl = line.split('\t')
        tup = (spl[0], spl[1], spl[4])
        snpdict[tup] = line

# Writes differing markers to output file.
for d in diff:
    f.write(snpdict[d])

# Output info
print("Output VCF written to: serial_differing_snps.vcf")
