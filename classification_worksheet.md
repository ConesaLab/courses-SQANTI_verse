# 🧬 SQANTI3 QC Classification File Worksheet

This worksheet is designed to help you explore and interpret the output of the SQANTI3 Quality Control module, specifically the `classification.txt` file. Use Python, bash, or any preferred method to answer the following questions.

---

## 🔍 **Basic Exploration**

1. **How many total transcript isoforms are present in the file?**  
   *(Hint: Count the number of unique values in the `isoform` column.)*

2. **How many unique genes are represented?**  
   *(Use the `associated_gene` column.)*

3. **What are the different `structural_category` values present, and how many isoforms fall into each?**  
   *(Expected categories: `full-splice_match`, `incomplete-splice_match`, `novel_in_catalog`, `novel_not_in_catalog`, `fusion`)*

---

## 📊 **Gene and Transcript Structure**

4. **What is the average number of exons per transcript?**  
   *(Use the `exons` column.)*

5. **Identify the transcript with the highest number of exons. What is its structural category and associated gene?**

6. **Find the longest and shortest transcripts based on the `length` column. What are their structural categories?**

---

## 🧪 **Novelty and Annotations**

7. **How many transcripts are classified as `novel_not_in_catalog`? How many unique genes do they represent?**

8. **How many transcripts are labeled as `fusion`? What gene pairs are involved in these fusions?**

9. **Filter transcripts where `associated_transcript` is `novel`. What percentage of the total do they represent?**

---

## 🧪 **Coding and ORFs**

10. **How many transcripts are predicted to be coding (`coding` column)?**

11. **Among coding transcripts, what is the average ORF length (`ORF_length` column)?**

12. **Which transcript has the longest predicted ORF, and what is its structural category?**

13. **How many transcripts are predicted to be subject to nonsense-mediated decay (`predicted_NMD = TRUE`)?**

---

## 🧠 **Advanced / Comparative**

14. **Compare the number of `full-splice_match` transcripts to `incomplete-splice_match` ones. What does this suggest about transcriptome completeness?**

15. **How many transcripts have a known reference transcript (`associated_transcript` != `novel`)?**

16. **Group transcripts by gene and determine which gene has the highest number of isoforms.**

---

## 📁 **Integration / Bonus**

17. **Using the `CDS_start` and `CDS_end`, compute the CDS length. Is it consistent with the value in the `CDS_length` column?**

18. **How many transcripts have canonical splice junctions (`all_canonical = TRUE`) vs. non-canonical ones?**

19. **How many transcripts contain polyA motifs (`polyA_motif_found = TRUE`)?**

20. **Are there any transcripts within a polyA site (`within_polyA_site = TRUE`) that do *not* have a polyA motif? How many?**

---

Let me know if you'd like a PDF version or to turn this into a collaborative worksheet with checkboxes or form fields!

