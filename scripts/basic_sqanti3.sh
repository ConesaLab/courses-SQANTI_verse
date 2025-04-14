#!/bin/bash 
set -e

# This script is used to run SQANTI3 on a given set of transcripts.
transcripts="data/raw_transcriptome.gtf"
reference_fasta="data/chr22_hg38.fasta"
reference_gtf="data/chr22_hg38.gtf"

sqanti3_qc.py \
    --isoforms $transcripts \
    --refGTF $reference_gtf \
    --refFasta $reference_fasta \
    --dir results/basic_sqanti3 --output course 