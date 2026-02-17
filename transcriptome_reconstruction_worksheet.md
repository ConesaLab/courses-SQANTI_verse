# 🏗️ Transcriptome Reconstruction Worksheet

This worksheet is designed to help you analyze the results of the transcriptome reconstruction step using IsoQuant. We will explore the output files located in `results/01_isoquant_transcriptome`.

---

## 📊 **Basic Statistics**

1. **How many transcript isoforms were reconstructed?**  
   *(Check the `mouse.transcript_models.gtf` file or count entries)*  
   <details><summary>Answer</summary>468 isoforms</details><br>

2. **How many genes were identified in the reconstruction?**  
   *(Check the `mouse.discovered_gene_counts.tsv` file)*  
   <details><summary>Answer</summary>394 genes</details><br>

3. **How many of these genes are considered "novel"? What percentage does this represent?**  
   *(Look at the `gene_id` format in the GTF or counts file. Novel genes usually have IDs starting with `novel_gene`)*  
   <details><summary>Answer</summary>394 genes are novel (100%). This is because IsoQuant was run without a reference annotation file (GTF), forcing it to perform *de novo* reconstruction of gene models, thus assigning new identifiers to all detected genes.</details><br>

---

## 🧬 **Transcript Structure**

4. **What is the average number of exons per transcript?**  
   *(You can parse the GTF file to calculate this)*  
   <details><summary>Answer</summary>10.13 exons on average</details><br>

5. **How many single-exon (mono-exonic) transcripts were reconstructed?**  
   <details><summary>Answer</summary>0 mono-exonic transcripts</details><br>

---

## 📈 **Abundance**

6. **Which gene has the highest expression count?**  
   *(Check `mouse.discovered_gene_counts.tsv`)*  
   <details><summary>Answer</summary>novel_gene_19_752 with 1139.0 counts</details><br>

7. **Which transcript has the highest expression count?**  
   *(Check `mouse.discovered_transcript_counts.tsv` and ignore `__no_feature`)*  
   <details><summary>Answer</summary>transcript751.19.nnic with 1139.0 counts</details><br>
