#!/bin/bash
set -e

# Activate FLAIR conda environment
eval "$(conda shell.bash hook)"
conda activate flair

# Ensure output directory exists
mkdir -p results/09_flair_transcriptome

# Aligning reads to genome
flair align --reads data/isoquant/mouse_raw_reads.subset.chr19.fastq \
            --genome data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
            --threads 8 \
            --output results/09_flair_transcriptome/mouse.aligned

# Generating transcriptome with reference annotation and short-read splice junctions
flair transcriptome --genomealignedbam results/09_flair_transcriptome/mouse.aligned.bam \
                    --genome data/reference/Mus_musculus.GRCm39.dna.chr19.fasta \
                    --gtf data/reference/Mus_musculus.GRCm39.115.chr19.gtf \
                    --junction_tab data/orthogonal/short_reads_chr19_SJ.out.tab \
                    --threads 8 \
                    --output results/09_flair_transcriptome/mouse
