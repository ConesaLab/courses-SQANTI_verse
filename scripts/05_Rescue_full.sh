#!/bin/bash

sqanti3_rescue.py \
    --filter_class results/04_Filter_orthogonal/mouse_RulesFilter_classification.txt \
    --refGTF data/isoquant/Mus_musculus.GRCm39.115.chr19.gtf \
    --refFasta data/isoquant/Mus_musculus.GRCm39.dna.chr19.fasta \
    --refClassif data/isoquant/reference_classification.txt \
    --mode full --strategy rules --requant \
    --json_filter data/filter_rules.json \
    --corrected_isoforms_fasta results/03_QC_with_orthogonal/mouse_corrected.fasta \
    --filtered_isoforms_gtf results/04_Filter_orthogonal/mouse.filtered.gtf \
    --counts results/01_isoquant_transcriptome/mouse.discovered_transcript_counts.clean.tsv \
    --dir results/05_Rescue_full --output mouse