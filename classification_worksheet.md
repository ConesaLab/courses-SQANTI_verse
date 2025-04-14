
# 🧫 SQANTI3 QC Classification File Worksheet

This worksheet is designed to help you explore and interpret the output of the SQANTI3 Quality Control module, specifically the `classification.txt` file. Use Python, bash, or any preferred method to answer the following questions.

---

## 🔍 **Basic Exploration**

1. **How many total transcript isoforms are present in the file?**  
   *(Hint: Count the number of unique values in the `isoform` column.)*  
   <details><summary>Answer</summary>3925</details><br>

2. **How many unique genes are represented?**  
   *(Use the `associated_gene` column.)*  
   <details><summary>Answer</summary>656</details><br>

3. **What are the different `structural_category` values present, and how many isoforms fall into each?**  
   *(Expected categories: `full-splice_match`, `incomplete-splice_match`, `novel_in_catalog`, `novel_not_in_catalog`, `fusion`)*  
   <details><summary>Answer</summary>{'novel_not_in_catalog': 1139, 'incomplete-splice_match': 1138, 'novel_in_catalog': 744, 'full-splice_match': 539, 'genic_intron': 147, 'genic': 113, 'intergenic': 41, 'fusion': 38, 'antisense': 26}</details><br>

---

## 📊 **Gene and Transcript Structure**

4. **What is the average number of exons per transcript?**  
   *(Use the `exons` column.)*  
   <details><summary>Answer</summary>8.36</details><br>

5. **Identify the transcript with the highest number of exons. What is its structural category and associated gene?**  
   <details><summary>Answer</summary>PB.3810.4 with 55 exons. Category: full-splice_match, Gene: ENSG00000241973.11</details><br>

6. **Find the longest and shortest transcripts based on the `length` column. What are their structural categories?**  
   <details><summary>Answer</summary>Shortest: PB.118877.1 (83 nt, genic), Longest: PB.3823.1 (10774 nt, full-splice_match)</details><br>

---

## 🧪 **Novelty and Annotations**

7. **How many transcripts are classified as `novel_not_in_catalog`? How many unique genes do they represent?**  
   <details><summary>Answer</summary>1139 transcripts, 273 unique genes</details><br>

8. **How many transcripts are labeled as `fusion`? What gene pairs are involved in these fusions?**  
   <details><summary>Answer</summary>38 fusion transcripts. Example gene pairs: ENSG00000100181.22_ENSG00000283633.1, ENSG00000100029.18_ENSG00000128242.13, and 15 more</details><br>

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

13. **How many transcripts are predicted to be subject to nonsense-mediated decay (`predicted_NMD = TRUE`)?**  
    <details><summary>Answer</summary>475</details><br>

---

## 🧠 **Advanced / Comparative**

14. **Compare the number of `full-splice_match` transcripts to `incomplete-splice_match` ones. What does this suggest about transcriptome completeness?**  
    <details><summary>Answer</summary>full-splice_match: 539, incomplete-splice_match: 1138. Suggests many partial isoforms</details><br>

15. **How many transcripts have a known reference transcript (`associated_transcript` != `novel`)?**  
    <details><summary>Answer</summary>1677</details><br>

16. **Group transcripts by gene and determine which gene has the highest number of isoforms.**  
    <details><summary>Answer</summary>ENSG00000099917.17 with 53 isoforms</details><br>

---

## 📁 **Integration / Bonus**

17. **Using the `CDS_start` and `CDS_end`, compute the CDS length. Is it consistent with the value in the `CDS_length` column?**  
    <details><summary>Answer</summary>Yes, all 3180 checked entries matched</details><br>

18. **How many transcripts have canonical splice junctions (`all_canonical = TRUE`) vs. non-canonical ones?**  
    <details><summary>Answer</summary>Canonical: 3028, Non-canonical: 310</details><br>

19. **How many transcripts contain polyA motifs (`polyA_motif_found = TRUE`)?**  
    <details><summary>Answer</summary>0</details><br>

20. **Are there any transcripts within a polyA site (`within_polyA_site = TRUE`) that do *not* have a polyA motif? How many?**  
    <details><summary>Answer</summary>0</details><br>