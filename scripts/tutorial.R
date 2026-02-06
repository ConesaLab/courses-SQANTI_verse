library(readr)
library(dplyr)

## Classification worksheet

# Load the datasets
basic.df <- read_tsv("results/02_QC_basic/mouse_classification.txt")

complete.df <- read_tsv("results/03_QC_with_orthogonal/mouse_classification.txt")

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
    mutate(fusion_genes= length(stringr::str_split(associated_gene,"_")[[1]])) %>%
    filter(fusion_genes == max(fusion_genes)) %>%
    select(isoform, fusion_genes, associated_gene)

# Question 9
basic.df %>%
    mutate(novel = ifelse(stringr::str_detect(associated_transcript,"novel"),TRUE,FALSE)) %>%
    select(novel) %>%
    table()/nrow(basic.df)*100 

# Question 10
basic.df %>% 
    select(coding) %>%
    table()

# Question 11
basic.df %>%
    filter(coding == "coding") %>%
    pull(CDS_length) %>%
    mean()

# Question 12
basic.df %>%
    filter(coding == "coding") %>%
    filter(CDS_length == max(CDS_length)) %>%
    select(isoform,CDS_length,structural_category)

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

# Question 16
complete.df %>%
    group_by(structural_category) %>%
    summarise(cov_mean = mean(min_cov,na.rm=TRUE),
              cov_sd = sd(min_cov,na.rm=TRUE)) 


# Question 17

complete.df %>%
    filter(structural_category == "incomplete-splice_match") %>%
    select(subcategory) %>%
    table()

complete.df %>%
    filter(structural_category == "incomplete-splice_match" &
          within_CAGE_peak & polyA_motif_found) %>%
    select(subcategory) %>%
    table()

# Question 18
complete.df %>%
    mutate(TSS_ratio = ifelse(ratio_TSS > 1,TRUE,FALSE)) %>%
    filter(!is.na(ratio_TSS)) %>%
    select(TSS_ratio) %>%
    table() 

library(ggplot2)
complete.df %>% 
    filter(!is.na(ratio_TSS)) %>%
    ggplot(aes(x=ratio_TSS,fill=within_CAGE_peak)) +
    geom_density(alpha=0.5) +
    scale_x_log10(expand = c(0, 0))  +
    scale_y_continuous(expand = c(0, 0)) +
    theme_bw() +
    theme(axis.text = element_text(size=16),
          axis.title = element_text(size=18),
          legend.text = element_text(size=16),
          legend.title = element_text(size=18)) +
    labs(x = "TSS ratio",
         y= "Density",
         fill = "Within a \nCAGE peak")

ggsave("results/03_QC_with_orthogonal/ratio_TSS_density.png") 


## Filter worksheet

basic.df <- read_tsv("results/04_Filter_basic/mouse_RulesFilter_classification.txt")
complete.df <- read_tsv("results/04_Filter_orthogonal/mouse_RulesFilter_classification.txt")

# Questions 4-5

basic.df %>% mutate(type="basic") %>%
    select(filter_result,type) %>%
    rbind(complete.df %>% mutate(type="complete") %>%
                          select(filter_result,type)) %>%
    table() 


# Question 6
pass_basic <- basic.df %>% filter(filter_result == "Isoform") %>%
    pull(isoform) 

complete.df %>%
    filter(filter_result == "Isoform" & !isoform %in% pass_basic) %>%
    select(structural_category) %>%
    table() 

complete.df %>% 
    filter(filter_result == "Isoform" & !isoform %in% pass_basic &
            structural_category == "full-splice_match") %>%
    select(isoform, structural_category, diff_to_gene_TSS,within_CAGE_peak)

complete.df %>% 
    filter(filter_result == "Isoform" & !isoform %in% pass_basic &
            structural_category == "incomplete-splice_match") %>%
    select(isoform, structural_category, length, subcategory,FSM_class,ratio_exp,within_CAGE_peak,polyA_motif_found)

## Rescue_questionaire

rescue.df <- read_tsv("results/05_Rescue_full/mouse_rescue_table.tsv")

# Question 1
rescue.df %>% 
    filter(rescue_mode == "automatic") %>%
    nrow()

# Question 2
rescue.df %>% 
    filter(rescue_mode == "automatic" ) %>%
    pull(assigned_transcript)  %>% unique()-> auto_reintroduced

complete.df %>% 
    filter(associated_transcript %in% auto_reintroduced) %>%
    nrow()

# Question 3

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% auto_reintroduced) %>%
    filter(!stringr::str_detect(associated_gene,"novel")) %>%
    pull(associated_gene) %>% 
    unique() %>% length()

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% auto_reintroduced) %>%
    pull(associated_transcript) %>% 
    unique() %>% length()

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% auto_reintroduced) %>%
    filter(associated_transcript == "novel")


#Question 4
candidate.df <- read_tsv("results/05_Rescue_full/mouse_rescue_candidates.tsv")
target.df <- read_tsv("results/05_Rescue_full/mouse_rescue_targets.tsv")

nrow(candidate.df)
nrow(target.df)

# Question 5
# Can also be done with "grep "PB" -c course_rescue_targets.tsv"
target.df %>% filter(stringr::str_detect(isoform,"transcript")) %>%
    nrow()

# Question 6
mapping_hits.df <- read_tsv("results/05_Rescue_full/mouse_rescue_mapping_hits.tsv")

mapping_hits.df %>% group_by(rescue_candidate) %>%
 summarise(n=n()) %>% 
 mutate(avg = mean(n),
        max = max(n))


# Question 7
new_classification.df <- read_tsv("results/05_Rescue_full/mouse_rescued_classification.txt")
nrow(new_classification.df)

rescue.df %>% select(rescue_mode) %>%
    table()

# Question 8
rescue.df %>% filter(rescue_mode == "rules_mapping" & origin == "lr_defined") %>%
    nrow()

# Question 9
requantification.df <- read_tsv("results/05_Rescue_full/mouse_reassigned_counts_extended.tsv")

requantification.df %>% filter(new_count == 0) %>% 
    pull(old_count) %>% sum()
requantification.df %>% pull(new_count) %>% sum()

# Question 10
requantification.df %>% 
    filter(old_count > 0 & new_count == 0) %>%
    nrow()

# Question 11
requantification.df %>% 
    filter(old_count == 0 & new_count > 0) %>%
    nrow()

