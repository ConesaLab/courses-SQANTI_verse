#!/bin/bash
set -e

# ==============================================================================
# SQANTI_verse Master Pipeline Script
# ==============================================================================
# This script executes all analysis steps of the course in sequential order.
# All paths are relative to the project working directory.
# ==============================================================================

# Initialize Conda shell environment
eval "$(conda shell.bash hook)"

echo "======================================================================"
echo "Step 0: SQANTI3 QC on Reference Annotation"
echo "======================================================================"
conda activate sqanti3
bash scripts/00_QC_reference.sh

echo "======================================================================"
echo "Step 1: IsoQuant Transcriptome Reconstruction (de novo)"
echo "======================================================================"
conda activate isoquant
bash scripts/01_generate_transcriptome.sh

echo "======================================================================"
echo "Step 2: Basic SQANTI3 QC on IsoQuant Transcriptome"
echo "======================================================================"
conda activate sqanti3
bash scripts/02_QC_basic.sh

echo "======================================================================"
echo "Step 3: SQANTI3 QC with Orthogonal Data"
echo "======================================================================"
conda activate sqanti3
bash scripts/03_QC_with_orthogonal.sh

echo "======================================================================"
echo "Step 4: SQANTI3 Rules-Based Filtering (Basic & Orthogonal)"
echo "======================================================================"
conda activate sqanti3
bash scripts/04_Filter.sh

echo "======================================================================"
echo "Step 5: SQANTI3 Rescue Module (ML Rescue)"
echo "======================================================================"
conda activate sqanti3
bash scripts/05_Rescue_full.sh

echo "======================================================================"
echo "Step 7: IsoQuant Transcriptome Reconstruction (Reference-Guided)"
echo "======================================================================"
conda activate isoquant
bash scripts/07_generate_transcriptome_with_reference.sh

echo "======================================================================"
echo "Step 8: SQANTI3 QC on Reference-Guided IsoQuant Transcriptome"
echo "======================================================================"
conda activate sqanti3
bash scripts/08_QC_with_reference.sh

echo "======================================================================"
echo "Step 9: FLAIR Transcriptome Reconstruction (flair align & transcriptome)"
echo "======================================================================"
conda activate flair
bash scripts/09_generate_flair_transcriptome.sh

echo "======================================================================"
echo "Step 10: SQANTI3 QC on FLAIR Transcriptome with Orthogonal Data"
echo "======================================================================"
conda activate sqanti3
bash scripts/10_SQANTI_QC_flair_orthogonal.sh

echo "======================================================================"
echo "🎉 SQANTI_verse Master Pipeline Completed Successfully!"
echo "======================================================================"
