# Create a new directory called tools inside the courses-SQANTI_verse directory
(sqanti3) courses-SQANTI_verse $
mkdir tools

(sqanti3) courses-SQANTI_verse $
cd tools

(sqanti3) courses-SQANTI_verse/tools $ 
git clone https://github.com/ConesaLab/SQANTI-browser.git

# Install SQANTI-browser (check out the wiki)
(sqanti3) courses-SQANTI_verse/tools $
cd SQANTI-browser

## After installation, run sqanti-browser on the example dataset 
(sqanti3) courses-SQANTI_verse $
python tools/SQANTI-browser/sqanti_browser.py --gtf tools/SQANTI-browser/example/SQANTI3_QC_output/example_corrected.gtf --classification tools/SQANTI-browser/example/SQANTI3_QC_output/example_classification.txt --output ./results/06_sqantiBrowser/QC --genome hg38 --tables --hub-name hub_QC --star-sj tools/SQANTI-browser/example/SQANTI3_QC_output/exampleSJ.out.tab --CAGE-peak tools/SQANTI-browser/example/SQANTI3_QC_output/chr22.human.refTSS_v3.1.hg38.bed --polyA-peak tools/SQANTI-browser/example/SQANTI3_QC_output/polyApeaks.atlas.GRCh38.bed

## Now run it on the filtered dataset, only producing tables
(sqanti3) courses-SQANTI_verse $
python tools/SQANTI-browser/sqanti_browser.py --gtf data/sqantiBrowser/UHR_chr22.filtered.gtf --classification data/sqantiBrowser/UHR_chr22_ML_result_classification.txt --output ./results/06_sqantiBrowser/filter --genome hg38 --tables --no-category-tracks --hub-name FILTER


# Task: load the QC hub into the genome browser 
Following the instructions on the hosting gide (create a github repo etc): https://github.com/ConesaLab/SQANTI-browser/wiki/hosting 
Alternatively, don't upload it to a new github repository and use the hub found in https://github.com/ConesaLab/courses-SQANTI_verse/tree/master_bioinformatica/.results/06_sqantiBrowser/QC/

Open the complete_transcriptome_isoforms.html of the FILTERED transcriptome that you have on results/06_sqantiBrowser/filter/table_reports

On the complete_transcriptome_isoforms.html, try out the different filters and find the coolest artifact you can find (the last column says which are artifacts)

Once found a cool artifact, look for it in the genome browser where you have open the hub of the QC. Try out showing or hiding other genome browser tracks and try to figure out an interesting reason why that transcript was deemed an artifact.