#!/bin/bash

# ===============================
# Alignment Pipeline (Chromosome2)
# Salmon Quantification
# Path: ~/genomics/ch2_project
# ===============================

# -----------------------------
# Define directories
# -----------------------------
PROJECT_DIR=~/genomics/ch2_project
REF_DIR=$PROJECT_DIR/references
TRIM_DIR=$PROJECT_DIR/trimmed_data
SALMON_DIR=$PROJECT_DIR/salmon_quant
LOG_DIR=$PROJECT_DIR/logs
SCRIPTS_DIR=$PROJECT_DIR/scripts

mkdir -p $SALMON_DIR $LOG_DIR $SCRIPTS_DIR

# -----------------------------
# Part 1: Build Salmon Index
# -----------------------------
echo "Building Salmon transcriptome index..."
salmon index \
    -t $REF_DIR/transcriptome_chr2.fa \
    -i $REF_DIR/salmon_index \
    --threads 4

echo "Salmon index completed."
ls -lh $REF_DIR/salmon_index/

# -----------------------------
# Part 2: Quantify Samples with Salmon
# -----------------------------
echo "Quantifying all samples with Salmon..."

SAMPLES="KO_1_SRR10045016 KO_2_SRR10045017 KO_3_SRR10045018 WT_1_SRR10045019 WT_2_SRR10045020 WT_3_SRR10045021"

for SAMPLE in $SAMPLES; do
    SHORT_NAME=$(echo $SAMPLE | cut -d'_' -f1,2)
    echo "Quantifying $SHORT_NAME..."

    salmon quant \
        -i $REF_DIR/salmon_index \
        -l A \
        -1 $TRIM_DIR/${SAMPLE}_1.trimmed.fastq.gz \
        -2 $TRIM_DIR/${SAMPLE}_2.trimmed.fastq.gz \
        -o $SALMON_DIR/${SHORT_NAME} \
        --threads 4 \
        --validateMappings \
        --gcBias \ # for gc contents
        --seqBias \ 
        2>> $LOG_DIR/salmon.log
done

echo "Quantification complete!"
ls -lh $SALMON_DIR/

# -----------------------------
# Part 3: Explore Salmon Output
# -----------------------------
echo "Checking Salmon quantification for KO_1..."
head -10 $SALMON_DIR/KO_1/quant.sf
echo "View logs for mapping rates:"
grep "Mapping rate" $LOG_DIR/salmon.log || echo "Check individual logs in $SALMON_DIR/*/logs/"

# -----------------------------
# Part 4: Tximport Aggregation (Gene Level Counts) >> because Salmon generates only transcript-level 
# -----------------------------
echo "Downloading tximport script..."
wget -O $SCRIPTS_DIR/run_tximport.R https://raw.githubusercontent.com/bioinfo-kaust/academy-stage3-2026/refs/heads/main/scripts/run_tximport.R
chmod +x $SCRIPTS_DIR/run_tximport.R

echo "Running tximport to aggregate transcript counts to gene level..."
Rscript $SCRIPTS_DIR/run_tximport.R \
    --gtf $REF_DIR/Homo_sapiens.GRCh38.115.chr2.gtf \
    --salmon_dir $SALMON_DIR \
    --outdir $PROJECT_DIR/counts

echo "Tximport completed. Gene-level counts are in $PROJECT_DIR/counts/"
ls -lh $PROJECT_DIR/counts/
