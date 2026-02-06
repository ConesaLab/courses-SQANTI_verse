import pandas as pd
import warnings

# Suppress warnings
warnings.filterwarnings("ignore")

# Load GTF
gtf_file = 'results/01_isoquant_transcriptome/mouse/mouse.transcript_models.gtf'
# Simple GTF parser
columns = ['seqname', 'source', 'feature', 'start', 'end', 'score', 'strand', 'frame', 'attribute']
gtf = pd.read_csv(gtf_file, sep='\t', comment='#', names=columns, header=None)

# Extract attributes
def parse_attributes(attr_str):
    attr_dict = {}
    if not isinstance(attr_str, str):
        return attr_dict
    for attr in attr_str.strip().split(';'):
        if not attr.strip():
            continue
        try:
            parts = attr.strip().split(' ')
            key = parts[0]
            val = parts[1].replace('"', '')
            attr_dict[key] = val
        except:
            continue
    return attr_dict

gtf['attributes_parsed'] = gtf['attribute'].apply(parse_attributes)
gtf['gene_id'] = gtf['attributes_parsed'].apply(lambda x: x.get('gene_id'))
gtf['transcript_id'] = gtf['attributes_parsed'].apply(lambda x: x.get('transcript_id'))

# 1. Total transcripts
transcripts = gtf[gtf['feature'] == 'transcript']
total_transcripts = len(transcripts)

# 2. Total genes
unique_genes = transcripts['gene_id'].nunique()

# 3. Novel genes
novel_genes = transcripts[transcripts['gene_id'].str.contains('novel_gene', na=False)]['gene_id'].nunique()
perc_novel = (novel_genes / unique_genes) * 100 if unique_genes > 0 else 0

# 4. Average exons
exons = gtf[gtf['feature'] == 'exon']
exons_per_transcript = exons.groupby('transcript_id').size()
avg_exons = exons_per_transcript.mean()
mono_exonic = (exons_per_transcript == 1).sum()

try:
    # Load Abundance - handle header with #
    gene_counts_file = 'results/01_isoquant_transcriptome/mouse/mouse.discovered_gene_counts.tsv'
    # Read first line to check header
    with open(gene_counts_file, 'r') as f:
        header_line = f.readline()
    
    if header_line.startswith('#'):
        gene_counts = pd.read_csv(gene_counts_file, sep='\t')
        gene_counts.columns = [c.replace('#', '') for c in gene_counts.columns]
    else:
        gene_counts = pd.read_csv(gene_counts_file, sep='\t')
        
    most_expressed_gene = gene_counts.loc[gene_counts['count'].idxmax()]

    transcript_counts_file = 'results/01_isoquant_transcriptome/mouse/mouse.discovered_transcript_counts.tsv'
    with open(transcript_counts_file, 'r') as f:
        header_line = f.readline()
        
    if header_line.startswith('#'):
        transcript_counts = pd.read_csv(transcript_counts_file, sep='\t')
        transcript_counts.columns = [c.replace('#', '') for c in transcript_counts.columns]
    else:
        transcript_counts = pd.read_csv(transcript_counts_file, sep='\t')
    
    most_expressed_transcript = transcript_counts.loc[transcript_counts['count'].idxmax()]
except Exception as e:
    print(f"Error processing abundance: {e}")
    most_expressed_gene = None
    most_expressed_transcript = None


print(f"Total transcripts: {total_transcripts}")
print(f"Total genes: {unique_genes}")
print(f"Novel genes: {novel_genes} ({perc_novel:.2f}%)")
print(f"Average exons: {avg_exons:.2f}")
print(f"Mono-exonic: {mono_exonic}")
if most_expressed_gene is not None:
    print(f"Most expressed gene: {most_expressed_gene['feature_id']} ({most_expressed_gene['count']})")
    print(f"Most expressed transcript: {most_expressed_transcript['feature_id']} ({most_expressed_transcript['count']})")
