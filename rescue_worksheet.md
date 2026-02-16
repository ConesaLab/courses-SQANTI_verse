# SQANTI3 rescue worksheet

In this final worksheet, we will go through the results obtained in the rescue module of SQANTI3. For this example, we have only run the full rescue using rules, since the automatic rescue is always run first. We will compare both outputs and see which isoforms were rescued, and why.

---

## 🤖 Automatic rescue 

For both parts of the exercise we will use the main rescue table `mouse_rescue_table.tsv` to see which transcripts were rescued in each mode, and all their respective information.

1. **How many transcripts were rescued automatically?**
    <details><summary>Answer</summary><br>
    76 transcripts
    </details><br>

2. **From the reintroduced transcripts, how many associated isoforms they had in total?** 
    <details><summary>Answer</summary><br>
    The rescued transcripts had 77 associated isoforms. (Kinda expected, as we are working with a small dataset)
    </details><br>
3. **Can you see how many transcripts and genes are still lost due to all of their isoforms being artifacts?**

    <details><summary>Answer</summary><br>
    There are 5 reference transcripts still lost after the automatic rescue. Also, 24 artifacts belong to novel transcripts.
    </details><br>

---

## :world_map:  Mapping candidates

4. **How many candidate and target transcripts have been selected?**

    <details><summary>Answer</summary>
    - Candidates: 67
    - Targets: 478
    </details><br>

5. **From the targets, how many are from the long read transcriptome and how many are reference transcripts?** 
*Hint: long-read transcripts begin with "transcript"*

    <details><summary>Answer</summary>
    
    - Reference: 35
    - Long-read transcriptome: 443
    </details><br>

6. **What is the average number of mapping hits that the candidates have? And the maximum?**

    <details><summary>Answer</summary>
    On average, there are 3.49 hits per candidate, and the candidate that mapped to the most targets mapped against 6 targets.
    </details><br>

## 🌕 Rescue by mapping (full)

7. **After the full rescue, how many isoforms are in the final transcriptome? How many were recovered in this last step?**

    <details><summary>Answer</summary>
    In total, we have 432 isoforms after rescue. 76 come from the automatic rescue and 76 come from the full rescue
    </details><br>

8. **Can you find any rescued isoform that comes from the long-reads data?**

    <details><summary>Answer</summary>
    In total, there are 26 long-read defined isoforms that are the best matching isoform for the candidates. 
    </details><br>


## Requantification

9. **How many counts were redistributed during the requantification step?** 

    <details><summary>Answer</summary>
    In total 3224 (from 12175 total counts)
    </details><br>

10. **How many artifact isoforms had their counts completely reassigned to rescued transcripts (lost all counts)?**

    <details><summary>Answer</summary>
    147 artifact isoforms lost all their counts during requantification, as they were redistributed to the rescued isoforms that better represent those reads.
    </details><br>

11. **How many new entries are there in the requantification table?**

    <details><summary>Answer</summary>
     There are 113 new entries in the requantification table. 111 belong to the reference transcripts reintroduced. However, the two new entries are the transcript divergence. One encapsulates the general transcript  divergence, with the counts of all the artifacts that did not have an associated transcript, and the other is the transcript divergence for the gene ENSMUSG00000003559, which had one artifact associated.
    </details><br>

