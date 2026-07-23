#!/bin/bash

# This script is used to run the QC module of SQANTI3 on a given set of transcripts.

sqanti3_qc.py \
    --isoforms results/01_isoquant_transcriptome/mouse_with_ref/mouse_with_ref.transcript_models.gtf \
    --refGTF data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
    --SR_bam data/orthogonal/short_reads_chr19_Aligned.sortedByCoord.out.bam \
    --coverage data/orthogonal/short_reads_chr19_SJ.out.tab \
    --CAGE_peak data/orthogonal/mouse.refTSS_v3.1.GRCm39.bed \
    --polyA_motif data/orthogonal/mouse_and_human.polyA_motif.txt \
    --fl_count results/01_isoquant_transcriptome/mouse.discovered_transcript_counts.clean.tsv \
    --include_ORF --dir results/08_QC_with_reference --output mouse --report both