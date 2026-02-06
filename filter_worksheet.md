# SQANTI filter worksheet

This worksheet is designed to guide you through the analysis of SQANTI3 Quality Control outputs, focusing on both the basic and complete classification.txt files. In the first part, you will examine each classification independently to understand how and why isoforms are assigned specific categories. In the second part, you will compare the two classifications to explore the impact of integrating orthogonal data sources—such as short reads, CAGE peaks, and polyA motifs—on transcript validation and interpretation.

## 🔍 Rules exploration

1. From the set of rules on the file `data/filter_rules.json`, **are you able to write down the explanation of what they will check?**
    *example: Keep FSM isoforms that are up to 50 nt from the reference TSS OR are within a CAGE peak AND have no Retrotranscriptase switching AND there are no more than 60% of As downstream the TSS*

    <details><summary>Answer</summary>
    - ISM:
        - Keep isoforms with all junctions canonical AND no RT switching AND having no FSM in their associated transcripts AND having more than 50% of the total expression for their associated gene AND no intra-priming OR
        - Keep isoforms between 2000nt and 15000 nt of length AND being a 3' prime fragment, 5' fragment or internal fragment AND having no RT switching AND no intra-priming OR 
        - Keep isoforms with no RT switching AND no intra-priming AND with both their TSS and TTS supported by orthogonal data (CAGE peak and polyA motif).
    - NIC:
        - All their junctions have to be canonical OR being supported by more than 10 reads AND being within 50nts of the reference TSS AND TTS OR
        - Having at least 10 reads in all their junctions AND being part of a CAGE peak and have a polyA motif
    - rest:
        - Have no RT switching AND being coding AND having less than 60% of As after the TTS (intra-priming candidates) AND at least two exons AND all the junctions canonical OR at least 10 reads to support each junction.
    

    </details><br>

2. **Which rules do you expect that will make a difference between the complete and the basic run?** 
    <details><summary>Answer</summary>
    The rule that include the following parameters:

    - min_cov
    - within_CAGE_peak
    - polyA_motif_found
    - ratio_exp

    Since they come from the orthogonal data only. For example, if a junction is not canonical but has at least 10 short reads that support it, it could be considered as valid, as the non-canonical junctions can also happen. 
    </details><br>

3. **Can you put an example of an ISM that would be considered an artifact in the basic run but not in the complete run?**
    <details><summary>Answer</summary>
    For this case, an ISM that has intron retention (the subcategory of `intron_retention` is considered an artifact here) would be eliminated in the basic run. However, this isoform would not be an artifact in the complete run if there are no FSMs for its associated gene (`FSM_class` B) and has 50% of the reads that mapped to the isoforms of the gene (`ratio_exp` > 0.5). As well, all of its junctions will have to be canonical. 
    </details><br>

## 🧠 Filter comparison

4. **How many isoforms are artifacts in the basic dataset?**  
    <details><summary>Answer</summary>
    115 isoforms are considered artifacts in the basic dataset. 
    </details><br>
5. **How many isoforms are artifacts in the complete dataset?**
    <details><summary>Answer</summary>
    98 isoforms are considered artifacts in the complete dataset. 
    </details><br>

6. **What is the distribution of the structural categories for the isoforms that passed the filter in the complete dataset but not in the basic dataset?**
    <details><summary>Answer</summary>

    | Structural Category       | count |
    |---------------------------|--------|
    | full-splice_match         | 14     |
    | incomplete-splice_match   | 3      |

    </details><br>

7. **Why did those isoforms pass the filter in the complete dataset but not in the basic dataset?** *Pick one of each structural category.* *hint: Check the outputs produced by SQANTI filter*

    <details><summary>Answer</summary>
    
    - FSM: The transcript 311 is 113 nucleotides downstream the reference TSS, but when using the complete dataset, it is within a CAGE peak.
    - ISM: The tree isoforms that pass here, despite not being complete, are supported by a CAGE peak and have a polyA motif, which is why they pass the filter in the complete dataset.
    
    </details><br>

8. **Can you explain any biological reason why we might want to include one of those isoforms even thought they failed the basic filtering?**

    <details><summary>Answer</summary>
    In the case of the FSM transcript 311, it can be that even though it is not within the expected TSS of the reference, the fact that is  supported by a CAGE peak might indicate that it is an alternative TSS.
    </details>