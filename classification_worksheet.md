
# 🧫 SQANTI3 QC Classification File Worksheet

This worksheet is designed to help you explore and interpret the output of the SQANTI3 Quality Control module, specifically the `classification.txt` file. Use Python, bash, or any preferred method to answer the following questions.

---

## 🔍 **Basic Exploration**

1. **How many total transcript isoforms are present in the file?**  
   <details><summary>Answer</summary>468 isoforms</details><br>

2. **How many unique genes are represented?**  
   *(Use the `associated_gene` column.)*  
   <details><summary>Answer</summary>317 unique reference genes</details><br>

3. **What are the different `structural_category` values present, and how many isoforms fall into each?**  
    
   <details><summary>Answer</summary>

    - full-splice_match: 348
    - novel_in_catalog: 57
    - novel_not_in_catalog: 43
    - incomplete-splice_match: 15
    - antisense: 3
    - fusion: 2
    </details><br>

---

## 📊 **Gene and Transcript Structure**

4. **What is the average number of exons per transcript?**  
   *(Use the `exons` column.)*  
   <details><summary>Answer</summary>10.13 exons on average</details><br>

5. **Identify the transcript with the highest number of exons. What is its structural category and associated gene?**  
   <details><summary>Answer</summary>transcript1426 with 40 exons. Category: novel_in_catalog, Gene: ENSMUSG00000025224</details><br>

6. **Find the longest and shortest transcripts based on the `length` column. What are their structural categories?**  
   <details><summary>Answer</summary>

   Shortest: 
   - transcript1514 (399 nt, full-splice_match)

   Longest: 
   - transcript1320 (8032 nt, full-splice_match)
</details><br>

---

## 🧪 **Novelty and Annotations**

7. **From the `novel_not_in_catalog` isoforms, how many have all of their junctions canonical?**
    *(Use the `all_canonical` column.)*  
   <details><summary>Answer</summary>There are 38 isoforms with all the junctions canonical and 5 with at least one non-canonical junction</details><br>

8. **From the isoforms classified as fusion, which one has the highest number of genes and what genes are they?**  
   <details><summary>Answer</summary> All fusion transcripts are formed by 2 genes. Highest: transcript1012. Genes: ENSMUSG00000052595_ENSMUSG00000118366</details><br>

9. **Filter transcripts where `associated_transcript` is `novel`. What percentage of the total do they represent?**  
   <details><summary>Answer</summary>22.44% of novel genes</details><br>

---

## 🧪 **Coding and ORFs**

10. **How many transcripts are predicted to be coding (`coding` column)?**  
    <details><summary>Answer</summary>435 transcripts are predicted to be coding</details><br>

11. **Among coding transcripts, what is the average CDS length (`CDS_length` column)?**  
    <details><summary>Answer</summary>1425 bp</details><br>

12. **Which transcript has the longest predicted CDS, and what is its structural category?**  
    <details><summary>Answer</summary>transcript1426, CDS length: 5574, Category: novel_in_catalog</details><br>

13. **How many transcripts are predicted to be subject to nonsense-mediated decay? What does it mean?**  
    <details><summary>Answer</summary>11.
    Nonsense-mediated decay (NMD) is a cellular mechanism that degrades mRNA transcripts containing premature stop codons, preventing the production of truncated proteins that could be harmful to the cell. SQANTI3 is able to flag transcripts like this if during the ORF prediction, a STOP codon is found before the TTS.
    <!-- TODO: Complete this with additional details on NMD and its implications for transcript analysis. -->
    </details><br>

---

## 🧠 **Advanced / Comparative**

Now, lets compare the classification file that used all of the orthogonal data, to see what extra information SQANTI3 is able to integrate.

14. **How many columns have been filled with information in the new classification? Name some of them.**  
    <details><summary>Answer</summary>
    There are 13 new columns that have been filled with information now, such as:
    
    - min_cov --> Minimum coverage of a splice junction
    - within_CAGE_peak
    - polyA_motif_found
    - FL --> Number of full-length reads supporting the isoform
    </details><br>

15. **From the FSM isoforms, how many have both support from a CAGE peak and a polyA motif? And the ISM?**  
    <details><summary>Answer</summary>
    - FSM: 216 isoforms
    - ISM: 6 isoforms
    </details><br>

16. **What is the average minimum coverage of a junction for each structural category?**
    <details><summary>Answer</summary>

    | Structural Category        | cov_mean | cov_sd |
    |---------------------------|----------|--------|
    | antisense                 | 0        | 0      |
    | full-splice_match         | 61.0     | 436.   |
    | fusion                    | 1.5      | 0.707  |
    | incomplete-splice_match   | 12.2     | 13.2   |
    | novel_in_catalog          | 21.2     | 123.   |
    | novel_not_in_catalog      | 1        | 2.13   |

    </details><br>

---

## 📁 **Integration**

17. **From the ISM isoforms that have support from a CAGE peak and a polyA motif, what are their subcategories? How would you explain this?.**  
    <details><summary>Answer</summary>

    - 3prime_fragment: 3
    - 5prime_fragment: 2  
    - internal_fragment: 0
    - intron_retention: 1  
    - mono-exon: 0

The fact that we see 3' fragments and 5' fragments with support in both their TSS and TTS suggests that these might be isoforms with alternative starts and end of transcription from what we can see in the reference annotation. However, the other ISMs that are not validated by the orthogonal data, might be more likely to be degradation products or artifacts.

</details><br>

18. **There is a hypothesis made in the SQANTI3 paper that states that the TSS ratio is higher on isoforms supported by a CAGE peak. Would you say that assumption is true based on the results you obtained?** Briefly explain why it would make sense or not. 

<!-- TODO: make this figure pretty -->

<details><summary>Answer</summary>
As we can see in the plot, there is a higher TSS ratio for the isoforms supported by a CAGE peak, which is consistent with the hypothesis. This is because CAGE peaks are indicative of real transcription start sites (and not artifacts of degradation), and isoforms with higher TSS ratios are more likely to be associated with such peaks.

<image src="results/03_QC_with_orthogonal/ratio_TSS_density.png" alt="TSS ratio plot" width="600"/>

</details><br>
