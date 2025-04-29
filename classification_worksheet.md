
# 🧫 SQANTI3 QC Classification File Worksheet

This worksheet is designed to help you explore and interpret the output of the SQANTI3 Quality Control module, specifically the `classification.txt` file. Use Python, bash, or any preferred method to answer the following questions.

---

## 🔍 **Basic Exploration**

1. **How many total transcript isoforms are present in the file?**  
   <details><summary>Answer</summary>3925</details><br>

2. **How many unique genes are represented?**  
   *(Use the `associated_gene` column.)*  
   <details><summary>Answer</summary>656</details><br>

3. **What are the different `structural_category` values present, and how many isoforms fall into each?**  
   *(Expected categories: `full-splice_match`, `incomplete-splice_match`, `novel_in_catalog`, `novel_not_in_catalog`, `fusion`)*  
   <details><summary>Answer</summary>
- full-splice_match: 1139
- incomplete-splice_match: 1138
- novel_in_catalog: 744
- full-splice_match: 539
- genic_intron: 147
- genic: 113
- intergenic: 41
- fusion: 38
- antisense: 26</details><br>

---

## 📊 **Gene and Transcript Structure**

4. **What is the average number of exons per transcript?**  
   *(Use the `exons` column.)*  
   <details><summary>Answer</summary>8.36</details><br>

5. **Identify the transcript with the highest number of exons. What is its structural category and associated gene?**  
   <details><summary>Answer</summary>PB.3810.4 with 55 exons. Category: full-splice_match, Gene: ENSG00000241973.11</details><br>

6. **Find the longest and shortest transcripts based on the `length` column. What are their structural categories?**  
   <details><summary>Answer</summary>Shortest: PB.118877.1 (83 nt, genic), Longest: PB.3823.1 (10774 nt, full-splice_match)</details><br>
<!-- TODO: Fix this to add the other isoforms -->
---

## 🧪 **Novelty and Annotations**

7. **From the `novel_not_in_catalog` isoforms, how many have all of their junctions canonical?**
    *(Use the `all_canonical` column.)*  
   <details><summary>Answer</summary>There are 851 isoforms with all the junctions canonical and 288 with at least one non-canonical junction</details><br>

8. **From the isoforms classified as fusion, which one has the highest number of genes and what genes are they?**  
   <details><summary>Answer</summary> All 38 fusion transcripts are formed by 2 genes. Example gene pairs: ENSG00000100181.22_ENSG00000283633.1, ENSG00000100029.18_ENSG00000128242.13, and 15 more</details><br>

9. **Filter transcripts where `associated_transcript` is `novel`. What percentage of the total do they represent?**  
   <details><summary>Answer</summary>57.27%</details><br>

---

## 🧪 **Coding and ORFs**

10. **How many transcripts are predicted to be coding (`coding` column)?**  
    <details><summary>Answer</summary>3180</details><br>

11. **Among coding transcripts, what is the average ORF length (`ORF_length` column)?**  
    <details><summary>Answer</summary>389.17 bp</details><br>

12. **Which transcript has the longest predicted ORF, and what is its structural category?**  
    <details><summary>Answer</summary>PB.3857.1, ORF length: 2414, Category: full-splice_match</details><br>

13. **How many transcripts are predicted to be subject to nonsense-mediated decay? What does it mean?**  
    <details><summary>Answer</summary>475.
    Nonsense-mediated decay (NMD) is a cellular mechanism that degrades mRNA transcripts containing premature stop codons, preventing the production of truncated proteins that could be harmful to the cell. SQANTI3 is able to flag transcripts like this if during the ORF prediction, a STOP codon is found before the TTS
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
    </details><br>

15. **From the FSM isoforms, how many have both support from a CAGE peak and a polyA motif? And the ISM?**  
    <details><summary>Answer</summary>
    - FSM: 336 isoforms
    - ISM: 107
    </details><br>

<!-- TODO: Find a good quesiton here -->

16. **Can you find any NNC isoforms 

---

## 📁 **Integration / Bonus**

17. **From the ISM isoforms found before, what are their subcategories? How would you explain this?.**  
    <details><summary>Answer</summary>

    - 3prime_fragment: 33  
    - 5prime_fragment: 34  
    - internal_fragment: 1  
    - intron_retention: 31  
    - mono-exon: 8
</details><br>

18. **How many transcripts have canonical splice junctions (`all_canonical = TRUE`) vs. non-canonical ones?**  
    <details><summary>Answer</summary>Canonical: 3028, Non-canonical: 310</details><br>

19. **How many transcripts contain polyA motifs (`polyA_motif_found = TRUE`)?**  
    <details><summary>Answer</summary>0</details><br>

20. **Are there any transcripts within a polyA site (`within_polyA_site = TRUE`) that do *not* have a polyA motif? How many?**  
    <details><summary>Answer</summary>0</details><br>