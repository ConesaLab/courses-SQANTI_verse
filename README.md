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
wget https://github.com/ConesaLab/SQANTI3/releases/download/v5.3.6/SQANTI3_v5.3.6.zip
mkdir -p tools/sqanti3
unzip SQANTI3_v5.3.6.zip -d tools/sqanti3
```

Once it is downloaded and unzipped, you can either add it to your PATH or call the programs using the full path. 

<details>
<summary><strong>Adding SQANTI3 to your PATH</strong></summary><br>

In the terminal, you have to find the file `.bashrc` or `.bash_profile` in your home directory. Use your favorite text editor to open it and add the following line

```bash
export PATH=$PATH:/path/to/SQANTI3_v5.3.6
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

The first step of the suite, and where the *SQANTI verse* begins in the Quality Control (QC) module. This module is designed to assess the quality of a transcriptome, and integrate multiple kinds of orthonogal data that might help to understand and determine what are the true isoforms. As an end result, SQANTI3 QC will take as input the target transcriptome and the reference genome and annotation. The user can optionally add other data sources, such as short-reads RNA-seq data or CAGE peaks, to include more parameters that will be used in downstream analysis. The QC module will parse all of this information and produce a report and a classification on the given isoforms based on the structural categories defined in the sqanti paper.

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

As well, SQANTI3 QC is able to determine CDS regions, using GeneMarkST as predictor for these parts of the transcriptome, or even recieve 

## 1.1. Basic run

Frirtly, to get familiar with SQANTI3 QC, we will run it with the most basic parameters. The only required parameters are the input transcriptome, the reference genome and the reference annotation. The rest of the parameters are optional, but they will be explained in the next sections. The way the inputs have to be given is as follows:

1. `--isoforms`: The input transcriptome. This can be a fasta file or a gtf/gff3 file. If you are using a fata file, the `--fasta` flag has to be included. This will allow SQANTI3 to parse the input file correctly and map the reads against the genome to produce the gtf.

2. `--refGTF`: Reference annotation in gtf format.
3. `--refFasta`: Reference genome in fasta format.

<details>
<summary><strong> ⚠️ Special considerations</strong></summary><br>

SQANTI3 was developed to work with PacBio long-reads transcriptomes. Thus, when parsing transcriptomes it will parse pacbio like transccitpt and gene IDs. If your data does not come from a PacBio experiment, you will need to add the `--force_id_ignore` flag to allow the usage of transcript IDs that do not follow the PacBio format (PB.X.Y)

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

- `course_corrected.gtf`: The corrected GTF file. This file contains the parsed input isofomrs, eliminating malformed lines from the GTF and correcting possible errors from the isoforms if they were given as a fasta files. This files will be the ones used by other SQANTI3 modules, rather than the original input files.

- `course_corrected.fasta`: The corrected fasta file. This file contains the parsed input isofomrs, eliminating malformed lines from the GTF and correcting possible errors from the isoforms if they were given as a fasta files. This files will be the ones used by other SQANTI3 modules, rather than the original input files.

- `course_corrected.genePred`: The corrected trasnscriptome in genePred format, since some steps  of SQANTI3 require this format for compabilitty with the orthogonal data.

- `course_corrected.gtf.cds.gff`: This file is a version of the corrected gtf that includes the preficted CDS regions. This file will be only produced if the option `--skipORF` is not included.

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

The most common extra information that you will use in combination with lr RNA-seq is short reads RNA data. While long-reads are fabulous for detmining the structure of an isoforme, since they are able to capture full transcirpts without the need of ana ssembly, they tend to be quite noisy and with high error rates, especially if they come from 'old' chesmitries. That is why, combining them with short reads is such a good idea. There reads will map to the transciptome and can be used for multiple purposes, such as identifying isoform expression, fixing indels or giving support to junctions. 



# 2. SQANTI3 filter

## 2.1 Rules 

# 3. SQANTI3 rescue


# 4. SQANTI3 reads

# 5. SQANTI3 wrapper