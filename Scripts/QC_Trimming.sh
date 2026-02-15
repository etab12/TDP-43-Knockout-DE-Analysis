#!/bin/bash

# ===============================
# RNA-seq Analysis (Chromosome 2) Project
# Path: ~/genomics/ch2_project
# ===============================

# -----------------------------
# Define directories
# -----------------------------
PROJECT_DIR=~/genomics/ch2_project
RAW_DIR=$PROJECT_DIR/raw_data
TRIM_DIR=$PROJECT_DIR/trimmed_data
QC_RAW_DIR=$PROJECT_DIR/qc_reports/fastqc_raw
QC_TRIM_DIR=$PROJECT_DIR/qc_reports/fastqc_trimmed
FASTP_DIR=$PROJECT_DIR/qc_reports/fastp
LOG_DIR=$PROJECT_DIR/logs

# Create directories
mkdir -p $TRIM_DIR $QC_RAW_DIR $QC_TRIM_DIR $FASTP_DIR $LOG_DIR

# -----------------------------
# Part 1: FastQC on Raw Data
# -----------------------------
echo "Running FastQC on raw FASTQ files..."
fastqc $RAW_DIR/*.fastq.gz -o $QC_RAW_DIR -t 4
echo "FastQC on raw reads completed."

# -----------------------------
# Part 2: Quality Trimming with fastp
# -----------------------------
echo "Running fastp for trimming and QC..."
SAMPLES="KO_1_SRR10045016 KO_2_SRR10045017 KO_3_SRR10045018 WT_1_SRR10045019 WT_2_SRR10045020 WT_3_SRR10045021"

for SAMPLE in $SAMPLES; do
    fastp \
        --in1 $RAW_DIR/${SAMPLE}_1.fastq.gz \
        --in2 $RAW_DIR/${SAMPLE}_2.fastq.gz \
        --out1 $TRIM_DIR/${SAMPLE}_1.trimmed.fastq.gz \
        --out2 $TRIM_DIR/${SAMPLE}_2.trimmed.fastq.gz \
        --qualified_quality_phred 20 \
        --length_required 36 \
        --detect_adapter_for_pe \
        --overrepresentation_analysis \
        --thread 4 \
        --json $FASTP_DIR/${SAMPLE}.json \
        --html $FASTP_DIR/${SAMPLE}.html \
        2>> $LOG_DIR/fastp.log
done
echo "trimming completed."

# -----------------------------
# Part 3: FastQC on Trimmed Data
# -----------------------------
echo "Running FastQC on trimmed FASTQ files..."
fastqc $TRIM_DIR/*.fastq.gz -o $QC_TRIM_DIR -t 4
echo "FastQC on trimmed reads completed."

# -----------------------------
# Part 4: MultiQC Report
# -----------------------------
echo "Generating MultiQC report..."
multiqc $PROJECT_DIR/qc_reports/ -o $PROJECT_DIR/qc_reports -n multiqc_all --force
echo "MultiQC report generated: $PROJECT_DIR/qc_reports/multiqc_all.html"

# -----------------------------
# Part 5: Summary of File Sizes
# -----------------------------
echo "=== Raw vs Trimmed File Sizes ==="
ls -lh $RAW_DIR/*_1.fastq.gz
ls -lh $TRIM_DIR/*_1.trimmed.fastq.gz

echo "Quality control finished successfully"
