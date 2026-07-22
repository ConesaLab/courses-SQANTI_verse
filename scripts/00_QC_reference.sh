#!/bin/bash

sqanti3_qc.py --isoforms data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refGTF data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
    --short_reads data/short_reads.fofn \
    --CAGE_peak data/orthogonal/mouse.refTSS_v3.1.GRCm39.bed \
    --polyA_motif data/orthogonal/mouse_and_human.polyA_motif.txt \
    --include_ORF --dir results/00_QC_reference --output reference
