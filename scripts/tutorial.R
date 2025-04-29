library(tidyverse)


# Load the datasets
basic.df <- read_tsv("results/basic_sqanti3/course_classification.txt")

complete.df <- read_tsv("results/complete_sqanti3/course_classification.txt")


# Question 1
nrow(basic.df)

# Question 2
basic.df %>% select(associated_gene) %>%
    distinct() %>%
    nrow()

# Question 3
basic.df %>%
    select(structural_category) %>%
    table()

# Question 4
basic.df %>% pull(exons) %>% mean()

# Question 5
basic.df %>% 
    filter(exons == max(basic.df$exons)) %>%
    select(isoform,exons,structural_category,associated_gene)

# Question 6
basic.df %>% 
    filter(length == max(basic.df$length) | length == min(basic.df$length)) %>%
    select(isoform,length,structural_category,associated_gene)

# Question 7
basic.df %>%
    filter(structural_category == "novel_not_in_catalog") %>% 
    select(all_canonical) %>%
    table()

# Question 8
basic.df %>% 
    filter(structural_category == "fusion") %>% 
    rowwise() %>%
    mutate(fusion_genes= length(str_split(associated_gene,"_")[[1]])) %>%
    filter(fusion_genes == max(fusion_genes)) %>%
    select(isoform, fusion_genes, associated_gene)

# Question 9
basic.df %>%
    mutate(novel = ifelse(str_detect(associated_transcript,"novel"),TRUE,FALSE)) %>%
    select(novel) %>%
    table()/nrow(basic.df)*100 

# Question 10
basic.df %>% 
    select(coding) %>%
    table()

# Question 11
basic.df %>%
    filter(coding == "coding") %>%
    pull(ORF_length) %>%
    mean()

# Question 12
basic.df %>%
    filter(coding == "coding") %>%
    filter(ORF_length == max(ORF_length)) %>%
    select(isoform,ORF_length,structural_category)

# Question 13
basic.df %>%
    filter(predicted_NMD) %>%
    select(structural_category) %>%
    table()

#Question 14
basic.df %>%
    select(where(~ !all(is.na(.)))) -> clean_basic.df

complete.df %>%
    select(where(~ !all(is.na(.)))) %>%
    colnames() %>%
    setdiff(clean_basic.df %>% colnames()) %>%
    length()

complete.df %>%
    select(where(~ !all(is.na(.)))) %>%
    colnames() %>%
    setdiff(clean_basic.df %>% colnames()) 

# Question 15

complete.df %>%
    filter(structural_category %in% c("full-splice_match","incomplete-splice_match") &
          within_CAGE_peak & polyA_motif_found) %>%
    select(structural_category) %>%
    table()

# Question 15

complete.df %>%
    filter(structural_category == "incomplete-splice_match" &
          within_CAGE_peak & polyA_motif_found) %>%
    select(subcategory) %>%
    table()
