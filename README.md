# SQANTI verse tutorial

## Introduction

<details>
<summary><strong>SQANTI3 structural categories</strong></summary>

1. <strong>Full-Splice-Match (FSM):</strong> Transcript models where all splice junctions perfectly match a known reference transcript.  
2. <strong>Incomplete-Splice-Match (ISM):</strong> Transcript models that match a consecutive subset of splice junctions of a known reference transcript.  
3. <strong>Novel-In-Catalog (NIC):</strong> Transcript models with at least one splice junction not present in the reference annotation, but formed by known splice sites.  
4. <strong>Novel-Not-In-Catalog (NNC):</strong> Transcript models with at least one splice junction that utilizes a novel splice site not present in the reference annotation.  
5. <strong>Antisense:</strong> Transcript models that align to a gene locus but on the opposite strand to all annotated transcripts of that gene.  
6. <strong>Fusion:</strong> Transcript models whose exons align to two or more distinct gene loci.  
7. <strong>Genic genomic:</strong> Transcript models composed of exons that align within a gene locus but do not reconstruct any known or novel splicing pattern.  
8. <strong>Intergenic:</strong> Transcript models whose exons align to genomic regions outside of any annotated gene.  

</details><br>


# 0. Pre-requisites

Before starting the tutorial, it is key to have a clean and organized working environment. The initial step, even before processing any data is to prepare the working environment. In bioinformatics, an organized workspace is vital, so when you come after some time to your project, you can find and understand what you were doing, rather than spend hours searching through weirdly named directories. It is important to always create three directories:


- scripts: all the scripts will be stored here, with meaningful names
- data: Raw data will go in here and, if you want and need, databases
- results: Create a sub directory for every different process you do. If you run a process multiple times with different parameters, include them in the directory name, so you will differentiate them in the future.

```bash
mkdir scripts
mkdir data
```

### Software installation

SQANTI3 can be directly downloaded from GitHub using the following command:

```bash
wget https://github.com/ConesaLab/SQANTI3/releases/download/v5.4/SQANTI3_v5.4.zip
mkdir -p tools/sqanti3
unzip SQANTI3_v5.4.zip -d tools/sqanti3
```

Once it is downloaded and unzipped, you can either add it to your PATH or call the programs using the full path. 

<details>
<summary><strong> 📃  Adding SQANTI3 to your PATH</strong></summary><br>

In the terminal, you have to find the file `.bashrc` or `.bash_profile` in your home directory. Use your favorite text editor to open it and add the following line

```bash
export PATH=$PATH:/path/to/SQANTI3_v5.4
```

Then, save the file and SQANTI3 will be in your path for the next terminal you open. As well, you can make this changes instantaneous by running `source ~/.bashrc` or `source ~/.bash_profile` in the terminal.

---
</details><br>

The final step to have a functional sqanti3 installation is to install the dependencies. SQANTI3 has a few dependencies that need to be installed before running the program, but that is all handled by anaconda or mamba, depending on which one you prefer (mamba is highly recommended for better environment solving and consistency).

```bash
mamba env create -f tools/sqanti3/SQANTI3.conda.env.yml
```

### Data downloading


# 1. SQANTI3 QC

The first step of the suite, and where the *SQANTI verse* begins in the Quality Control (QC) module. This module is designed to assess the quality of a transcriptome, and integrate multiple kinds of orthogonal data that might help to understand and determine what are the true isoforms. As an end result, SQANTI3 QC will take as input the target transcriptome and the reference genome and annotation. The user can optionally add other data sources, such as short-reads RNA-seq data or CAGE peaks, to include more parameters that will be used in downstream analysis. The QC module will parse all of this information and produce a report and a classification on the given isoforms based on the structural categories defined in the sqanti paper.

<details>
<summary><strong> 🏗️ SQANTI3 structural categories</strong></summary><br>

1. <strong>Full-Splice-Match (FSM):</strong> Transcript models where all splice junctions perfectly match a known reference transcript.  
2. <strong>Incomplete-Splice-Match (ISM):</strong> Transcript models that match a consecutive subset of splice junctions of a known reference transcript.  
3. <strong>Novel-In-Catalog (NIC):</strong> Transcript models with at least one splice junction not present in the reference annotation, but formed by known splice sites.  
4. <strong>Novel-Not-In-Catalog (NNC):</strong> Transcript models with at least one splice junction that utilizes a novel splice site not present in the reference annotation.  
5. <strong>Antisense:</strong> Transcript models that align to a gene locus but on the opposite strand to all annotated transcripts of that gene.  
6. <strong>Fusion:</strong> Transcript models whose exons align to two or more distinct gene loci.  
7. <strong>Genic genomic:</strong> Transcript models composed of exons that align within a gene locus but do not reconstruct any known or novel splicing pattern.  
8. <strong>Intergenic:</strong> Transcript models whose exons align to genomic regions outside of any annotated gene.  

---
</details><br>

As well, SQANTI3 QC is able to determine CDS regions, using GeneMarkST as predictor for these parts of the transcriptome, or even recieve the isoforms in fasta format. SQANTI will map them against the reference genome and produce a gtf file to run with. 

## 1.1. Basic run

Firstly, to get familiar with SQANTI3 QC, we will run it with the most basic parameters. The only required parameters are the input transcriptome, the reference genome and the reference annotation. The rest of the parameters are optional, but they will be explained in the next sections. The way the inputs have to be given is as follows:

1. `--isoforms`: The input transcriptome. This can be a fasta file or a gtf/gff3 file. If you are using a fata file, the `--fasta` flag has to be included. This will allow SQANTI3 to parse the input file correctly and map the reads against the genome to produce the gtf.

2. `--refGTF`: Reference annotation in gtf format.
3. `--refFasta`: Reference genome in fasta format.

<details>
<summary><strong> ⚠️ Special considerations</strong></summary><br>

SQANTI3 was developed to work with PacBio long-reads transcriptomes. Thus, when parsing transcriptomes it will parse PacBio like transcripts and gene IDs. If your data does not come from a PacBio experiment, you will need to add the `--ignore` flag to allow the usage of transcript IDs that do not follow the PacBio format (PB.X.Y)

---
</details><br>

```bash
sqanti3_qc.py \
    --isoforms data/isoforms.fasta \
    --refGTF data/genome.fa \
    --refFasta data/annotation.gtf \
    --dir results/basic_sqanti3 --output course 
```

In this run, SQANTI3 will be carried out in its most basic functions. First, it will parse all inputs and load them. Then, it will predict the Open Reading Frames within the contigs, to determine if the isoforms are coding or not. It will also look at the Retrotranscriptase Switching and the percentage of A content after the TTS. Finally, it will produce the classification of the isoforms in the SQANTI3 categories. Now, lets, dive into the output files.

<details>
<summary><strong> 📤 Output files</strong></summary><br>

The output files are stored in the directory `results/basic_sqanti3/course`. In this directory, you will find a few files and directories. The most important ones are:

- `course_corrected.gtf`: The corrected GTF file. This file contains the parsed input isoforms, eliminating malformed lines from the GTF and correcting possible errors from the isoforms if they were given as a fasta files. This files will be the ones used by other SQANTI3 modules, rather than the original input files.

- `course_corrected.fasta`: The corrected fasta file. This file contains the parsed input isoforms, eliminating malformed lines from the GTF and correcting possible errors from the isoforms if they were given as a fasta files. This files will be the ones used by other SQANTI3 modules, rather than the original input files.

- `course_corrected.genePred`: The corrected transcriptome in genePred format, since some steps  of SQANTI3 require this format for compatibility with the orthogonal data.

- `course_corrected.gtf.cds.gff`: This file is a version of the corrected gtf that includes the predicted CDS regions. This file will be only produced if the option `--skipORF` is not included.

- `course_classification.txt`: The classification file. This file contains the classification of the isoforms in the SQANTI3 categories. This file is the most important output of SQANTI3 QC, as it contains the information about the quality of the transcriptome and the classification of the isoforms.

- `course_junctions.txt`: A tab-separated file with information at the junction level for all transcriptomes included in the classification file. Each row represents a specific junction and includes details such as genomic coordinates, whether it is a canonical junction (e.g., GT-AG, GC-AG, AT-AC) or non-canonical, and whether it is known (present in the reference annotation) or novel.

- `course_SQANTI3_report.html`: The SQANTI3 report. This file contains a summary of the results and the classification of the isoforms. It is an HTML file that can be opened in any web browser. The report contains a summary of the results, including the number of isoforms, the number of genes, the number of junctions, and the classification of the isoforms. It also contains plots and figures that help to visualize the results.

- `course.qc_params.txt`: The QC parameters file. This file contains the parameters used in the run, including the input files, the reference genome and annotation, and the options used in the run. This file is useful to keep track of the parameters used in the run and to reproduce the results.

---
</details><br>

<details>
<summary><strong> 📊 SQANTI3 concepts</strong></summary><br>

### **Canonical and Non-Canonical Junctions**

* **Canonical junctions** are the dinucleotide pairs most commonly found at the ends of introns and are efficiently recognized by the splicing machinery. The most common pairs considered canonical are **GT-AG**, **GC-AG**, and **AT-AC**. The GT-AG combination is the most abundant in the human genome, representing around 98.9% of introns. Together, these three canonical combinations are found in over 99.9% of human introns. By default, SQANTI considers these three pairs as canonical but allows users to define their own set of canonical junctions using the `--sites` parameter.

* **Non-canonical junctions** include all other dinucleotide combinations at intron boundaries that are not considered canonical. These junctions are much less frequent and are often associated with splicing errors or artifacts.

* **Detection by SQANTI:** SQANTI analyzes transcript sequences and compares the dinucleotides present at the ends of each intron (defined by donor and acceptor splice sites) with the set of canonical junctions.
    * In the classification file (`classification.txt`), the `all_canonical` column indicates whether all junctions in an isoform have canonical splice sites.
    * In the junctions file (`junctions.txt`), the `splice_site` column shows the specific splicing motif of each junction. The `start_site_category` and `end_site_category` columns indicate whether the start and end sites of the junction are annotated as "known" in the reference annotation file. The `junction_category` column shows whether the donor-acceptor combination is "known" or "novel".
    * SQANTI calculates and reports the proportion of canonical and non-canonical junctions across different transcript categories to help identify possible artifacts. For instance, a high proportion of non-canonical junctions in certain novel transcript categories (such as NNC) may suggest a higher likelihood of being artifacts.

### **RT Switching (Reverse Transcriptase Template Switching)**

* **RT switching** is a phenomenon that occurs during reverse transcription, where the reverse transcriptase (RT) may prematurely switch RNA templates during cDNA synthesis. This can happen due to secondary structures in the messenger RNA or the presence of direct repeats in the RNA sequences. RT switching can generate spurious cDNA that is misinterpreted as splicing events, often resulting in non-canonical junctions. RT switching events have been observed to be enriched in low-abundance transcripts from highly expressed genes.

* **Detection by SQANTI:** SQANTI implements an algorithm to predict potential RT switching artifacts. The algorithm scans all junctions (both canonical and non-canonical) for direct repeat patterns at defined sequence locations characteristic of RT switching.
    * In the classification file (`classification.txt`), the `RTS_stage` column is set to TRUE if one of the isoform's junctions may be an RT switching artifact.
    * In the junctions file (`junctions.txt`), the `RTS_junction` column is set to TRUE if the junction is predicted to be a template-switching artifact.
    * SQANTI analyzes the frequency of RT switching predictions across different transcript categories and junction types to help users identify potential artifacts introduced during cDNA library preparation. For example, a higher proportion of RT switching predictions in NNC transcripts may indicate that these are more likely to be artifacts.

By identifying and characterizing canonical and non-canonical junctions, as well as potential RT switching artifacts, SQANTI supports quality control and curation of long-read transcriptomes, enabling more accurate identification of real isoforms.

---
</details><br>

For now, we will focus on the main output from SQANTI,the classification file (you can get more information about the other output on the tab above). This file contains 48 columns with information about the isoforms and the results from the run. Two important columns are the `structural_category`, which indicates the structural category that each isoform belongs to, and `associated_gene`, which indicates the reference gene that a certain isoform is associated with (if any). 

**:question: Trivia:** Check the `classification_worksheet.md` try to answer as many questions as you can. You can use any programming language or tool to answer the questions. The questions are designed to help you understand the output of SQANTI3 QC and the classification file. 

With this, you have completed a basic run of SQANTI3 QC, and you have learned how to run it and what are the main output files. In the next sections, we will explore the additional inputs that SQANTI3 QC is able to integrate, and how to use them to improve the results of the classification.

## 1.2 Run with additional inputs

The most common extra information that you will use in combination with lr RNA-seq is short reads RNA data. While long-reads are fabulous for determining the structure of an isoform, since they are able to capture full transcirpts without the need of an assembly, they tend to be quite noisy and with high error rates, especially if they come from 'old' chemistries. That is why, combining them with short reads is such a good idea. There reads will map to the transciptome and can be used for multiple purposes, such as identifying isoform expression, fixing indels or giving support to junctions. 

The other two main types of orthogonal data that SQANTI3 QC can use are CAGE peaks and polyA sites. CAGE peaks are used to identify the transcription start sites (TSS) of the isoforms, while polyA sites are used to identify the transcription termination sites (TTS) of the isoforms. These two types of data can be used to improve the classification of the isoforms, and to distinguis between true isoforms and artifacts caused by degradation of the RNA, for instance.

```bash
sqanti3_qc.py \
    --isoforms data/isoforms.fasta \
    --refGTF data/genome.fa \
    --refFasta data/annotation.gtf \
    --dir results/basic_sqanti3 --output course \
    --shortReads data/short_reads.bam
    --CAGEpeaks data/CAGE_peaks.bed
```

When it comes to the ouptut files, they won't change much form a SQANTI3 run without the extra information. The main difference will be within the report, where some of the columns that were NAs before, now will be filled with the information from the short-reads, CAGE peaks and polyA motifs. **:question: Trivia: Which columns have now information that before didn't?**

<details>
<summary><strong> 🤔 Solution </strong></summary>
<!-- TODO: Complete -->
</details><br>

With this, you have completed a run of SQANTI3 QC, the first and central module of the SQANTI-verse. You have learned how to run it, what are the main output files and how to use additional information to improve the classification of the isoforms. In the next sections, we will explore the other modules of SQANTI3, which are designed to curate and filter the transcriptome based on the results from SQANTI3 QC.

# 2. SQANTI3 filter

The SQANTI3 filter module provides **two primary technical approaches for curating long-read transcriptomes by removing potential artifacts**: a **rules-based filter** and a **machine learning-based filter**. The rules filter operates by applying user-defined criteria, expressed in a **JSON format**, to the **SQANTI3 QC classification file** (`*_classification.txt`). These rules specify characteristics that reliable isoforms should possess, considering various QC attributes. The machine learning filter, on the other hand, employs a **random forest classifier** trained on **true positive (TP) and true negative (TN) isoform sets**, leveraging **SQANTI3 QC attributes** to predict the probability of a transcript being a genuine isoform or an artifact. Both filtering methods can generate a filtered classification file and optionally filter associated **FASTA/FASTQ, GTF, SAM, and FAA files** based on the identified high-quality isoforms.

For the sake of this tutorial, we will focus on the rules-based filter, which allows for more flexibility and customization from the user. The first step here is to understand how the filter works.

## 2.1 Rules 

The rules filter is based on a set of rules (surprise!) that are defined in a JSON file. SQANTI3 filter comes by default with its own set of rules, which do a really basic filtering of the isoforms. The way the rules work is the following:

1. Create a set of rules for a specific structural category (or for all under the tag 'rest').
2. The rules are treated as OR conditions, meaning that if an isoform passes any of the rules, it will be kept. 
3. Within a rule, the user can set multiple conditions, which are based on the attributes of the SQANTI3 QC classification file. These conditions are treated as AND conditions, meaning that all conditions within a rule have to be met for the isoform to be kept.

The conditions includes must have the same name name as the columns in the classification file, and you can use 3 possible value types:  

1. A single integer to denote the minimum value
2. A range of integers, using the format `[min,max]` to denote the range of values.
3. A string or a list of strings to denote a specific value or a list of values.

<details>
<summary><strong> 📜 Example of rules</strong></summary><br>

* **FSM**: Keep if the isoform is:
    * NOT a potential intrapriming product (less than 60% in the `perc_A_downstream_TTS` column). **OR**
    * It is larger than 2kb **AND** has more than 1 exon
* **ISM**: Keep if:
    * It is larger than 2kb and shorter than 15kb **AND**
    * It is catalogued within the "3prime_fragment", "5prime_fragment" or "internal_fragment" subcategories.

```json
{
    "full-splice_match": [
        {
            "perc_A_downstream_TTS":[0,59]
        },
        {
            "length": 2001,
            "exon_count": 2
        }
    ],
    "incomplete-splice_match":[
        {
            "length":[2001,14999],
            "subcategory": ["3prime_fragment", "5prime_fragment", "internal_fragment"]
        }
    ]
}
```
</details><br>

>Note: In case of a condition being added but the column being an NA (not having information in the classification file), the rule check will automatically fail. This is important to keep in mind when creating the rules, as you might accidentally add a condition that you did not analyze and cause all of your isoforms to fail because of it. 

**:question: Trivia:** Now, try to create your own set of rules for the following conditions:

* **FSM**: Keep if the isoform:
  * Has a `perc_A_downstream_TTS` lower than 60% (not likely intrapriming) **AND**
  * Has no RT Switching

* **ISM**: Keep if:
  * Has no RT Switching **AND**
  * It belongs to subcategories "3prime_fragment" or "5prime_fragment".

* **NIC**: Keep if:
  * The junctions are all canonical **OR**
  * The minimum coverage (`min_cov`) is greater than or equal to 5.

* **NNC**: Keep if:
  * The junctions are all canonical **AND**
  * Distance to the closest TSS (`diff_to_gene_TSS`) and TTS (`diff_to_gene_TTS`) is within ±50 bp.

* **Rest of the categories**: Keep if:
  * The transcript is coding  **AND**
  * It is not an intrapriming artifact **AND**
  * It has at least 2 exons **AND**
  * The splice junctions are canonical **AND**
  * It is not an RTS artifact.

<details>
<summary><strong> 🤔 Solution </strong></summary>

```json
{
  "full-splice_match": [
    {
      "perc_A_downstream_TTS": [0, 59],
      "RTS_stage": false
    }
  ],
  "incomplete-splice_match": [
    {
      "length": [2000, 15000],
      "subcategory": ["3prime_fragment", "5prime_fragment"]
    }
  ],
  "novel_in_catalog": [
    {
      "all_canonical": "canonical"
    },
    {
      "min_cov": 5
    }
  ],
  "novel_not_in_catalog": [
    {
      "all_canonical": "canonical",
      "diff_to_gene_TSS": [-50, 50],
      "diff_to_gene_TTS": [-50, 50]
    }
  ],
  "rest": [
    {
      "coding": "coding",
      "perc_A_downstream_TTS": [0, 59],
      "exons": 2,
      "all_canonical": "canonical",
      "RTS_stage": false
    }
  ]
}
```
</details><br>

Now, that you know the basics of the rules filter, lets dive into running it. The rules module comes with two different subparsers, one for the rules strategy and another for the machine learning strategy. Most of the inputs given are common, and in our case, the only special input will be the JSON file with the actual rules. For the sake of this tutorial, we will use one rule file for the two classifications we did, the one without the orthogonal data and the one with it. 

```bash
sqanti3_filter.py rules \
    --sqanti3_class <classification_file> \
    --filter_gtf <path_to_sqanti3_dir>/course_corrected.gtf \
    --json_filter data/rules.json \
    --dir results/rules_filter --output course 
```

You will have to run this command twice, once for each classification file. Remember to also change the output directory, so one run won't overwrite the other. Once both runs are finished, move to the questionnaire `filter_worksheet.md` and try to answer the questions. You can use any programming language or tool to answer the questions. The questions are designed to help you understand the output of SQANTI3 filter and the classification file.

# 3. SQANTI3 rescue

The final module of the SQANTI3 pipeline is rescue. The aim of this module is to prevent the loss of transcripts from long-read data that might be biologically relevant but could be discarded due to not being accurately processed. In the end, because of degradation form an isoforms or issues during sequencing, we might not fully capture and during filtering consider the transcript to be an artifact. SQANTI3 rescue offers two different approaches towards the isoform recovery:

1. **Automatic rescue:** This first approach is run always, and by default. It focuses on recovering high-confidence reference isoforms by identifying reference transcripts for which all corresponding Full Splice Match (FSM) isoforms were removed during the filtering stage. 

2. **Full rescue:** After the automatic rescue of the FSM transcripts, the rest of structural categories undergo rescue. For that, they are considered to be candidates to be rescued, and the targets are both the reference isoforms that they have assigned, plus the respective long-read transcripts. 

The rescued transcriptome will include the rescued isoforms, ensuring that no redundancy is introduced. Meaning that if a reference transcript is going to be reintroduced, SQANTI3 rescue will always check first if it is already present in the transcriptome. 

> Note: The full rescue pipeline will slightly change based on the filter stategy applied, since the reference transcriptome has to be processed following the same strategy as the long-reads transcriptome

In order to run SQANTI3 rescue in full mode, you need to have run SQANTI3 QC on the reference annotation against itself, using the same orthogonal data as in your dataset. This step has already been done for you, but if you want to test yourself, go ahead and try to run it 😉. 

<details> 
<summary> Code to run SQANTI3 QC on the reference </summary>
```bash
sqanti_qc.py \
    --isoforms data/chr22_hg38.gtf \
    --refGTF data/chr22_hg38.gtf \
    --refFasta data/chr22_hg38.gtf \
    --short_reads data/short_reads.fofn \
    --CAGE_peak data/ref_TSS_annotation/human.refTSS_v3.1.hg39.bed \
    --polyA_motif_list data/polyA_motifs/mouse_and human.polyA_motif.txt \
    --dir reference_sqanti3 --output reference
```
</details><br>

In this tutorial, we will run the both the automatic and full rescue, to see the differences in the results in both methods. First, the automatic rescue is straightforward script. Even though it 

```bash 
sqanti3_rescue.py rules \
    --sqanti3_class 

```

The automatic rescue will produce a new transcriptome with the rescued transcripts from the reference, and a list of which were included. Now, we will run the full rescue. This approach continues from the automatic rescue. We need to specify the same strategy as was used in the filtering of our trasnscriptome, so the reference transcriptome is processed in the same way. The command is as follows:

```bash
sqanti_rescue.py rules \
    --sqanti3_class <> \
    --mode full 
```

This pipeline is a bit more complex. It follows four main steps to rescue the isoforms:

1. **Candidate and target selection:** Candidate isoforms are the ISM, NIC and NNC isoforms that were considered as artifacts in the filtering step. The rescue targets are all the reference or long read-defined transcripts that are associated with the candidate isoforms. 

2. **Maping of the candidates to the targets:** Minimap2 is used to map the candidates to the targets and find the best matches between each target and the same gene candidates. 

3. **Filtering of the reference isoforms:** Using the same strategy as with the long-read transcriptome, the reference isoforms are run through the SQANTI3 filter module. This step is done to validate the reference transcripts using the orthogonal data.

4. **Rescue of the isoforms:** In the final step, the rescue-by-mapping takes place. The mapping hits (candidate-target mapping pairs) are run through a series of criteria:
    - If the rescue target did not pass the filter, the candidate-target will be removed.
    - Long read transcripts will be discarded if there is another mapping hit for the same candidate isoform to a target that is from the reference transcriptome.
    - If the candidate isoform is already present in the transcriptome as a FSM or has already been rescued in the automatic part, it will be discarded to avoid redundancy.
 
The output in this case will be the same as before, but most likely, more transcripts will be rescued. To finish with the SQANTI3 tutorial, lets go and complete the last worksheet `rescue_worksheet.md`. The questions are designed to help you understand the output of SQANTI3 rescue and why some isoforms were rescued and others not.

# SQANTI filter questions
The idea of this worksheet is first to see individually the basic and complete filter classifications, to understand why the isoforms have been classified as they are.The second part of the analysis resides in understanding the differences between both classificaitons, as a way to show the imporatnce of SQANTI3 QC integration of thatw: For exapme. if we focus on the FSM isoforms, we can see that in the basic classification we are loosing isoforms that are "far" from the reference TSS and could be deemed as arfiacts fdue to degratation. However, in the complete classification, thanks to the CAGE peak data, we can see that some of these isoforms could actually be valid isoforms with alternative TSS, sicne they fall within a CAGE peak.

The idea is to play around with this data
# 5. SQANTI3 wrapper

As of release v5.4, a new wrapper script and configuration file for SQANTI3 have been added. This wrapper is designed to simplify the process of running SQANTI3 and its associated modules. The wrapper script allows users to specify the input files, output directories, and all the parameters in a single configuration file, making it easier to manage and run multiple analyses. The wrapper also includes options for running SQANTI3 QC, filter, and rescue in a single command, streamlining the workflow for users.

