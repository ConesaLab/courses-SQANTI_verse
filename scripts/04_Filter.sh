#!/bin/bash 
set -e

rules_file="data/filter_rules.json"

# BASIC SQANTI3

sqanti3_filter.py rules \
    --sqanti_class "results/02_QC_basic/mouse_classification.txt" \
    --filter_gtf results/02_QC_basic/mouse_corrected.gtf \
    --json_filter $rules_file \
    --dir results/04_Filter_basic --output mouse 

# COMPLETE SQANTI3

sqanti3_filter.py rules \
    --sqanti_class "results/03_QC_with_orthogonal/mouse_classification.txt" \
    --filter_gtf results/03_QC_with_orthogonal/mouse_corrected.gtf \
    --json_filter $rules_file \
    --dir results/04_Filter_orthogonal --output mouse