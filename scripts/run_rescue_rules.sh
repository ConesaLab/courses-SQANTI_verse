#!/bin/bash

sqanti3_rescue.py rules \
    --filter_class results/complete_filter/course_RulesFilter_result_classification.txt \
    --refGTF data/reference/gencode.v38.basic_chr22.gtf \
    --refFasta data/reference/GRCh38.p13_chr22.fasta \
    --refClassif data/reference/gencode.v38.basic_chr22_classification.txt \
    --mode full \
    --json_filter data/filter_rules.json \
    --rescue_isoform results/complete_sqanti3/course_corrected.fasta \
    --rescue_gtf results/complete_sqanti3/course_corrected.gtf \
    --dir results/complete_rescue --output course