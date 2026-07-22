#!/bin/bash
set -e

# Format FLAIR count table for SQANTI3 compatibility (adds header and matches transcript IDs)
python3 scripts/clean_flair_counts.py \
    results/09_flair_transcriptome/mouse.isoforms.gtf \
    results/09_flair_transcriptome/mouse.isoform.counts.txt \
    results/09_flair_transcriptome/mouse.isoform.counts.clean.tsv

# This script runs the QC module of SQANTI3 on the FLAIR reconstructed transcriptome
sqanti3_qc.py \
    --isoforms results/09_flair_transcriptome/mouse.isoforms.gtf \
    --refGTF data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
    --SR_bam data/orthogonal/short_reads_chr19_Aligned.sortedByCoord.out.bam \
    --coverage data/orthogonal/short_reads_chr19_SJ.out.tab \
    --CAGE_peak data/orthogonal/mouse.refTSS_v3.1.GRCm39.bed \
    --polyA_motif data/orthogonal/mouse_and_human.polyA_motif.txt \
    --fl_count results/09_flair_transcriptome/mouse.isoform.counts.clean.tsv \
    --include_ORF --dir results/10_QC_flair --output mouse --report both
