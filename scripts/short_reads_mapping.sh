#!/bin/bash
set -e

# ==============================================================================
# Short Read Mapping with STAR (SQANTI3 Parameters)
# ==============================================================================
# This script performs STAR indexing and 2-pass mapping of short reads using
# the exact parameters defined in SQANTI3 (src/utilities/short_reads.py).
# ==============================================================================

# Input files and configuration
GENOME="data/reference/Mus_musculus.GRCm39.dna.chr19.fasta"
READ1="data/isoquant/short_reads.chr19.subset.r1.fq"
READ2="data/isoquant/short_reads.chr19.subset.r2.fq"
THREADS=8

# Output directory structure matching SQANTI3 conventions
OUTPUT_DIR="results/short_read_mapping"
INDEX_DIR="${OUTPUT_DIR}/STAR_index"
MAPPING_DIR="${OUTPUT_DIR}/STAR_mapping"
SAMPLE_NAME="short_reads_chr19"
SAMPLE_PREFIX="${MAPPING_DIR}/${SAMPLE_NAME}_"

# Create output directories
mkdir -p "${INDEX_DIR}" "${MAPPING_DIR}"

echo "=========================================="
echo "Step 1: Generating STAR Genome Index"
echo "=========================================="
STAR \
    --runThreadN ${THREADS} \
    --runMode genomeGenerate \
    --genomeDir "${INDEX_DIR}" \
    --genomeFastaFiles "${GENOME}" \
    --outTmpDir "${INDEX_DIR}/_STARtmp"

echo "=========================================="
echo "Step 2: Mapping Short Reads with STAR"
echo "=========================================="
# Check if input FASTQ files are compressed (.gz)
READ_FILES_CMD=""
if [[ "${READ1}" == *.gz ]]; then
    READ_FILES_CMD="--readFilesCommand zcat"
fi

STAR \
    --runThreadN ${THREADS} \
    --genomeDir "${INDEX_DIR}" \
    --readFilesIn "${READ1}" "${READ2}" \
    --outFileNamePrefix "${SAMPLE_PREFIX}" \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterType BySJout \
    --outSAMunmapped Within \
    --outFilterMultimapNmax 20 \
    --outFilterMismatchNoverLmax 0.04 \
    --outFilterMismatchNmax 999 \
    --alignIntronMin 20 \
    --alignIntronMax 1000000 \
    --alignMatesGapMax 1000000 \
    --sjdbScore 1 \
    --genomeLoad NoSharedMemory \
    --outSAMtype BAM SortedByCoordinate \
    --twopassMode Basic \
    ${READ_FILES_CMD}

echo "Mapping completed successfully. Output files saved in: ${MAPPING_DIR}"
