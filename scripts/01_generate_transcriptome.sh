#!/bin/bash

source activate isoquant

# Generating the transcriptome directly with IsoQuant (no reference annotation)
isoquant.py --fastq data/isoquant/mouse_raw_reads.subset2.chr19.fastq \
            --reference data/isoquant/Mus_musculus.GRCm39.dna.chr19.fasta \
            -d pacbio --output results/01_isoquant_transcriptome --prefix second_subset
