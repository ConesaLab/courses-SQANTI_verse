#!/bin/bash

# This script is used to run the QC module of SQANTI3 on a given set of transcripts.

sqanti3_qc.py \
    --isoforms results/01_isoquant_transcriptome/mouse.transcript_models.clean.gtf \
    --refGTF data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
    --include_ORF --dir results/02_QC_basic --output mouse