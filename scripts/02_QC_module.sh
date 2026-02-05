#!/bin/bash

# This script is used to run the QC module of SQANTI3 on a given set of transcripts.
source activate sqanti3

sqanti3_qc.py \
    --isoforms results/01_isoquant_transcriptome/mouse.transcript_models.clean.gtf \
    --refGTF data/isoquant/Mus_musculus.GRCm39.104.chr19.gtf \
    --refFasta data/isoquant/Mus_musculus.GRCm39.dna.chr19.fasta \
    --include_ORF --ir results/02_QC_module --output mouse