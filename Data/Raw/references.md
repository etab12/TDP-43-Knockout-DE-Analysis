## Raw Sequencing Data

Raw RNA-seq data are publicly available at:

Accession: GSE136366

Repository: Gene Expression Omnibus (GEO)

Link:
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE136366


# Reference Preparation

All reference files were obtained from Ensembl Release 115 (GRCh38).

1. Chromosome2 Genome Sequence

Download chromosome2 FASTQ:

bash 

wget https://ftp.ensembl.org/pub/release-115/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.2.fa.gz
gunzip Homo_sapiens.GRCh38.dna.chromosome.2.fa.gz

2. Gene Annotation (GTF)

Download full annotation:
bash 

wget https://ftp.ensembl.org/pub/release-115/gtf/homo_sapiens/Homo_sapiens.GRCh38.115.gtf.gz
gunzip Homo_sapiens.GRCh38.115.gtf.gz


Extract chromosome2 annotations:
bash

grep -E "^#|^2	" Homo_sapiens.GRCh38.115.gtf > Homo_sapiens.GRCh38.115.chr2.gtf

3. Chromosome2 Transcriptome (cDNA)

Download full transcriptome:
bash 

wget https://ftp.ensembl.org/pub/release-115/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz


Extract chromosome2 transcripts:

bash

gunzip -c Homo_sapiens.GRCh38.cdna.all.fa.gz | \
awk '/^>/ {keep = /chromosome:GRCh38:2:/} keep' > transcriptome_chr2.fa
