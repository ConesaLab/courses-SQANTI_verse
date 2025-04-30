# SQANTI3 rescue worksheet

In this final worksheet, we will go throught the results obtained in the rescuce module of SQANTI3. For this example, we have only run the full rescue using rules, which also contains the automatic fist. We will compare both outputs and see which isoforms were rescued, and why.

---

## 🤖 Automatic rescue 

For this part of the exercise you have to use the `course_automatic_rescued_list.tsv` to see which transcripts were rescued.

1. **How many transcripts were rescued automatically?**
    <details><summary>Answer</summary><br>
    140 transcripts
    </details><br>

2. **Those rescued transcripts, how many associated isoforms had in total?** 
    <details><summary>Answer</summary><br>
    The rescued transcripts had 281 associated isoforms
    </details><br>
3. **Can you see how many transcripts and genes are still lost due to all of their isoforms being artifacts?**

    <details><summary>Answer</summary><br>
    There are 384 reference transcrips still lost after the automatic rescue. Also, 1045 artifacts belong to novel transcipts.
    </details><br>

<!--TODO: FInish once I find the str_detect function fof R -->

---

## :world_map:  Mapping candidates

4. **How many candidate and target transcirpts have been selected?**

    <details><summary>Answer</summary>
    - Candidates: 1705
    - Targets: 2474
    </details><br>

5. **From the targets, how many are from the long read transcriptome and how many are reference transcripts?** 
*Hint: long-read transcripts begin with "PB"*

    <details><summary>Answer</summary>
    
    - Reference: 1028
    - Long-read transcriptome: 1446
    </details><br>

6. **What is the average number of mapping hits that the candidates have? And the maximum?**

    <details><summary>Answer</summary>
    On average, there are 4.24 hits per candidate, and the candidate that mapped to the most targets mapped against 8 targets.
    </details><br>

## 🌕 Full rescue

7. **After the full rescue, how many isoforms are in the final transcirptome? How many were recovered in this last step?**

    <details><summary>Answer</summary>
    In total, we have 2068 isoforms after rescue. 140 come from the automatic rescue and 468 come from the full rescue
    </details><br>

8. **Can you find any rescued isoform that comes from the long-reads data?**

    <details><summary>Answer</summary>
    No isoforms from the long read transcriptome were rescued
    </details><br>