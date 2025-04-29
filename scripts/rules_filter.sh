#!/bin/bash 
set -e

rules_file="data/filter_rules.json"

# BASIC SQANTI3

sqanti3_filter.py rules \
    --sqanti_class "results/basic_sqanti3/course_classification.txt" \
    --json_filter $rules_file \
    --dir results/basic_filter --output course 

# COMPLETE SQANTI3

sqanti3_filter.py rules \
    --sqanti_class "results/complete_sqanti3/course_classification.txt" \
    --json_filter $rules_file \
    --dir results/complete_filter --output course