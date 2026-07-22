#!/bin/bash
set -e

# Generating the transcriptome directly with IsoQuant (no reference annotation)
isoquant --fastq data/isoquant/mouse_raw_reads.subset.chr19.fastq \
         --reference data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
         --genedb data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
         --threads 8 -d pacbio --output results/01_isoquant_transcriptome --prefix mouse_with_ref

# Cleaning up the transcript IDs and counts
python scripts/clean_transcript_ids.py -g results/01_isoquant_transcriptome/mouse/mouse.transcript_models.gtf \
    -a results/01_isoquant_transcriptome/mouse/mouse.discovered_transcript_counts.tsv \
    -o results/01_isoquant_transcriptome
