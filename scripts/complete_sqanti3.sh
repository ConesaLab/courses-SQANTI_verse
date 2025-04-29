#!/bin/bash 
set -e

# This script is used to run SQANTI3 on a given set of transcripts.
transcripts="data/raw_transcriptome.gtf"
reference_fasta="data/chr22_hg38.fasta"
reference_gtf="data/chr22_hg38.gtf"
short_reads="data/short_reads.fofn"
CAGE_peak="data/ref_TSS_annotation/human.refTSS_v3.1.hg38.bed"
polyA_motifs="data/polyA_motifs/mouse_and_human.polyA_motif.txt"

sqanti3_qc.py \
    --isoforms $transcripts \
    --refGTF $reference_gtf \
    --refFasta $reference_fasta \
    --short_reads $short_reads \
    --CAGE_peak $CAGE_peak \
    --polyA_motif_list $polyA_motifs \
    --dir results/complete_sqanti3 --output course 