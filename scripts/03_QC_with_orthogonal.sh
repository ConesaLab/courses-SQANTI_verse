#!/bin/bash

# This script is used to run the QC module of SQANTI3 on a given set of transcripts.
source activate sqanti3

sqanti3_qc.py \
    --isoforms results/01_isoquant_transcriptome/mouse.transcript_models.clean.gtf \
    --refGTF data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
    --short_reads data/short_reads.fofn \
    --CAGE_peak data/orthogonal/mouse.refTSS_v3.1.GRCm39.bed \
    --polyA_motif data/orthogonal/mouse_and_human.polyA_motif.txt \
    --fl_count results/01_isoquant_transcriptome/mouse.discovered_transcript_counts.clean.tsv \
    --include_ORF --dir results/03_QC_with_orthogonal --output mouse