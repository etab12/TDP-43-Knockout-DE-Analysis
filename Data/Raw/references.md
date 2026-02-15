📂 Raw Sequencing Data

Raw sequencing data are publicly available from:

Accession: GSE136366

Database: Gene Expression Omnibus

Link:
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE136366

 
🧬 Reference Preparation (Ensembl GRCh38 Release 115)
1️⃣ Download Chromosome 2 Genome (FASTA)
'''bash
wget https://ftp.ensembl.org/pub/release-115/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.2.fa.gz
gunzip Homo_sapiens.GRCh38.dna.chromosome.2.fa.gz
'''

Output:

Homo_sapiens.GRCh38.dna.chromosome.2.fa

2️⃣ Download Gene Annotation (GTF)
Download Full Annotation File
wget https://ftp.ensembl.org/pub/release-115/gtf/homo_sapiens/Homo_sapiens.GRCh38.115.gtf.gz
gunzip Homo_sapiens.GRCh38.115.gtf.gz

Extract Chromosome 2 Annotations Only
grep -E "^#|^2	" Homo_sapiens.GRCh38.115.gtf > Homo_sapiens.GRCh38.115.chr2.gtf


Output:

Homo_sapiens.GRCh38.115.chr2.gtf

3️⃣ Download Transcriptome (cDNA)
Download Full cDNA Reference
wget https://ftp.ensembl.org/pub/release-115/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz

Extract Chromosome 2 Transcripts Only
gunzip -c Homo_sapiens.GRCh38.cdna.all.fa.gz | \
awk '/^>/ {keep = /chromosome:GRCh38:2:/} keep' > transcriptome_chr2.fa


Output:

transcriptome_chr2.fa

