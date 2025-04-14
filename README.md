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
<summary><strong>Adding SQANTI3 to your PATH</strong></summary>

In the terminal, you have to find the file `.bashrc` or `.bash_profile` in your home directory. Use your favorite text editor to open it and add the following line

```bash
export PATH=$PATH:/path/to/SQANTI3_v5.3.6
```

Then, save the file and SQANTI3 will be in your path for the next terminal you open. As well, you can make this changes instantaneous by running `source ~/.bashrc` or `source ~/.bash_profile` in the terminal.
</details><br>

The final step to have a functional sqanti3 installation is to install the dependencies. SQANTI3 has a few dependencies that need to be installed before running the program, but that is all handled by anaconda or mamba, depending on which one you prefer (mamba is highly recommended for better environment solving and consistency).

```bash
mamba env create -f tools/sqanti3/SQANTI3.conda.env.yml
```

### Data downloading


# 1. SQANTI3 QC

The first step of the suite, and where the *SQANTI verse* begins in the Quality Control (QC) module. This module is designed to assess the quality of a transcriptome, and integrate multiple kinds of orthonogal data that might help to understand and determine what are the true isoforms. As an end result, SQANTI3 QC will take as input the target transcriptome and the reference genome and annotation. The user can optionally add other data sources, such as short-reads RNA-seq data or CAGE peaks, to include more parameters that will be used in downstream analysis. The QC module will parse all of this information and produce a report and a classification on the given isoforms based on the structural categories defined in the sqanti paper.

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

As well, SQANTI3 QC is able to determine CDS regions, using GeneMarkST as predictor for these parts of the transcriptome, or even recieve 

## 1.1. Basic run

Frirtly, to get familiar with SQANTI3 QC, we will run it with the most basic parameters. The only required parameters are the input transcriptome, the reference genome and the reference annotation. The rest of the parameters are optional, but they will be explained in the next sections. The way the inputs have to be given is as follows:

1. `--isoforms`: The input transcriptome. This can be a fasta file or a gtf/gff3 file. If you are using a fata file, the `--fasta` flag has to be included. This will allow SQANTI3 to parse the input file correctly and map the reads against the genome to produce the gtf.

2. `--refGTF`: Reference annotation in gtf format.
3. `--refFasta`: Reference genome in fasta format.

<details>
<summary><strong>:warning: Special considerations</strong></summary>

SQANTI3 was developed to work with PacBio long-reads transcriptomes. Thus, when parsing transcriptomes it will parse pacbio like transccitpt and gene IDs. If your data does not come from a PacBio experiment, you will need to add the `--force_id_ignore` flag to allow the usage of transcript IDs that do not follow the PacBio format (PB.X.Y)
</details>

```bash
sqanti3_qc.py \
    --isoforms data/isoforms.fasta \
    --refGTF data/genome.fa \
    --refFasta data/annotation.gtf \
    --dir results/basic_sqanti3 --output course 
```

In this run, SQANTI3 will be carried out in its most basic functions. First, it will parse all inputs and load them. Then, it will predict the Open Reading Frames within the contigs, to determine if the isoforms are coding or not. It will also look at the Retrotranscriptase Switching and the percentage of A content after the TTS. Finally, it will produce the classification of the isoforms in the SQANTI3 categories. Now, lets, dive into the output files.

Firstly, you will see the corrected version of the isoforms, in both gtf and fasta format (``)

## 1.2 Run with additional inputs


# 2. SQANTI3 filter

## 2.1 Rules 

# 3. SQANTI3 rescue


# 4. SQANTI3 reads

# 5. SQANTI3 wrapper