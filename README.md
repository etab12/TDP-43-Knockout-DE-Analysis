

 # TDP-43 KO vs WT RNA-seq Analysis (Chromosome 2)

This project was completed as part of the **KAUST Academy Advanced Bioinformatics** course. It implements a complete RNA-seq analysis workflow, starting from raw sequencing data and progressing through quality control, quantification, differential expression analysis, visualization, and pathway enrichment analysis.

The study compares **TDP-43 knockout (KO)** and **wildtype (WT)** samples, with a specific focus on genes located on **Chromosome 2**, to investigate the transcriptional consequences of TDP-43 deletion.

## Objective

To investigate the transcriptional impact of TDP-43 deletion by identifying significantly dysregulated genes and enriched biological pathways, with emphasis on Chromosome 2.

---

## Project Structure

```
project-name/
│
├── data/
│   ├── raw/                # Raw RNA-seq FASTQ files
│   └── counts/             # Gene/transcript count matrices
│
├── scripts/                # Analysis scripts for the RNA-seq pipeline
│
├── results/
│   ├── differential_expression/   # DE result tables
│   ├── plots/                     # DEGs plots.
│   └── pathway_analysis/          # Enrichment analysis plots
│
└── README.md
```

---

## Workflow Overview

### 1. Raw Data Processing
- Download and handling raw RNA-seq FASTQ files
- Initial data preparation

### 2. Quality Control
- Assessment of sequencing quality using FastCQ and Fastp
- Evaluation of read metrics before downstream analysis

### 3. Expression Quantification
- Generation of gene or transcript count matrices with Salmon
- Preparation of input data for statistical analysis

### 4. Differential Expression Analysis
-  Conducting DE analysis with DESeq 
- Identification of significantly upregulated and downregulated genes

### 5. Visualization
- Volcano plots
- Heatmaps
- Expression distribution plots

### 6. Pathway Enrichment Analysis
- Identification of overrepresented biological pathways
- Interpretation of biological relevance

 ### 7. Results

The final report includes:

- Top significantly differentially expressed genes (upregulated and downregulated)  
- Associated pathways and biological functions of these genes  
- Insights from recent studies investigating the roles of these genes, particularly on **Chromosome 2**, in neurodegenerative diseases and related pathways

 
