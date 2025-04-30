library(readr)
library(dplyr)

## Classification worksheet

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

# Question 16
complete.df %>%
    group_by(structural_category) %>%
    summarise(cov_mean = mean(min_cov,na.rm=TRUE),
              cov_sd = sd(min_cov,na.rm=TRUE)) 


# Question 17

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
    scale_x_log10()  +
    theme_bw() +
    labs(x = "TSS ratio",
         y= "Density",
         fill = "Within a \nCAGE peak")
ggsave("results/complete_sqanti3/ratio_TSS_density.png") 


## Filter worksheet

basic.df <- read_tsv("results/basic_filter/course_RulesFilter_result_classification.txt")
complete.df <- read_tsv("results/complete_filter/course_RulesFilter_result_classification.txt")

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
    select(isoform, structural_category, length, subcategory,FSM_class,ratio_exp)


complete.df %>% 
    filter(filter_result == "Isoform" & !isoform %in% pass_basic &
            structural_category == "novel_in_catalog") %>%
    select(isoform, all_canonical, min_cov,diff_to_gene_TTS, polyA_motif_found)

## Rescue_questionaire

automatic_rescued <- read_tsv("results/complete_rescue/course_automatic_rescued_list.tsv", 
col_names="transcript")

# Question 1
nrow(automatic_rescued)

# Question 2
complete.df %>% 
    filter(associated_transcript %in% automatic_rescued$transcript) %>%
    nrow()

# Question 3

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% automatic_rescued$transcript) %>%
    filter(!str_detect(associated_gene,"novel")) %>%
    pull(associated_gene) %>% 
    unique() %>% length()

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% automatic_rescued$transcript) %>%
    pull(associated_transcript) %>% 
    unique() %>% length()

complete.df %>% 
    filter(filter_result == "Artifact" & ! associated_transcript %in% automatic_rescued$transcript) %>%
    filter(associated_transcript == "novel")


#Question 4
candidate.df <- read_tsv("results/complete_rescue/course_rescue_candidates.tsv")
target.df <- read_tsv("results/complete_rescue/course_rescue_targets.tsv")

nrow(candidate.df)
nrow(target.df)

# Question 5
# Can also be done with "grep "PB" -c course_rescue_targets.tsv"
str_detect()

# Question 6
mapping_hits.df <- read_tsv("results/complete_rescue/course_rescue_mapping_hits.tsv",col_names = c("candidate","target","cigar"))

mapping_hits.df %>% group_by(candidate) %>%
 summarise(n=n()) %>% 
 mutate(avg = mean(n),
        max = max(n))


# Question 7
final_inclusion.df <- read_tsv("results/complete_rescue/course_rescue_inclusion-list.tsv",col_names="transcript")

final_inclusion.df %>% 
    filter(!transcript %in% automatic_rescued$transcript) %>% 
    nrow()
