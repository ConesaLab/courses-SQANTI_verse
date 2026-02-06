#!/bin/bash

# This script is used to run the QC module of SQANTI3 on a given set of transcripts.
source activate sqanti3

sqanti3_qc.py \
    --isoforms results/01_isoquant_transcriptome/mouse.transcript_models.clean.gtf \
    --refGTF data/isoquant/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/isoquant/Mus_musculus.GRCm39.dna.chr19.fasta \
    --short_reads data/short_reads.fofn \
    --include_ORF --dir results/03_QC_with_orthogonal --output mouse