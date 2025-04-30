# SQANTI filter worksheet

This worksheet is designed to guide you through the analysis of SQANTI3 Quality Control outputs, focusing on both the basic and complete classification.txt files. In the first part, you will examine each classification independently to understand how and why isoforms are assigned specific categories. In the second part, you will compare the two classifications to explore the impact of integrating orthogonal data sources—such as short reads, CAGE peaks, and polyA motifs—on transcript validation and interpretation.

## 🔍 Rules exploration

1. From the set of rules on the file `data/filter_rules.json`, **are you able to write down the explanation of what they will check?**
    *example: Keep FSM isoforms that are up to 50 nt from the reference TSS OR are 50 nts downstream of a CAGE peak AND have no Retrotranscriptase switching AND there are no more than 60% of As downstream the TSS*
    <!-- TODO: complete this part -->

    <details><summary>Answer</summary>
    - ISM:
        -  
    

    </details><br>

2. **Which rules do you expect that will make a difference between the complete and the basic run?** 
    <details><summary>Answer</summary>

    </details><br>

3. **Can you put an example of an ISM that would be considered an artifact in the basic run but not in the complete run?**
    <details><summary>Answer</summary>
    For this case, an ISM that has intron retention (the subcategory of `intron_retention` is considered an artifact here) would be eliminated in the basic run. However, this isoform would not be an artifact in the complete run if there are no FSMs for its associated gene (`FSM_class` B) and has 50% of the reads that mapped to the isoforms of the gene (`ratio_exp` > 0.5). As well, all of its junctions will have to be canonical. 
    </details><br>

## 🧠 Filter comparison

4. **How many isoforms are artifacts in the basic dataset?**  
    <details><summary>Answer</summary>
    2624 isoforms are considered artifacts in the basic dataset. 
    </details><br>
5. **How many isoforms are artifacts in the complete dataset?**
    <details><summary>Answer</summary>
    2544 isoforms are considered artifacts in the complete dataset. 
    </details><br>

6. **What is the distribution of the structural categories for the isoforms that passed the filter in the complete dataset but not in the basic dataset?**
    <details><summary>Answer</summary>

    | Structural Category       | count |
    |---------------------------|--------|
    | full-splice_match         | 70     |
    | incomplete-splice_match   | 8      |
    | novel_in_catalog          | 2      |
    </details><br>

7. **Why did those isoforms pass the filter in the complete dataset but not in the basic dataset?** *Pick one of each structural category.*

    <details><summary>Answer</summary>

    </details><br>

8. **Can you explain any biological reason why we might want to include one of those isoforms even thought they failed the basic filtering?**

<!-- Complete -->