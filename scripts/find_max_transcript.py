import pandas as pd
import warnings
warnings.filterwarnings("ignore")

try:
    transcript_counts_file = 'results/01_isoquant_transcriptome/mouse/mouse.discovered_transcript_counts.tsv'
    # Check if header has #
    with open(transcript_counts_file, 'r') as f:
        header = f.readline()
    
    if header.startswith('#'):
        df = pd.read_csv(transcript_counts_file, sep='\t')
        df.columns = [c.replace('#', '') for c in df.columns]
    else:
        df = pd.read_csv(transcript_counts_file, sep='\t')
    
    # Filter out __no_feature or similar
    df = df[~df['feature_id'].astype(str).str.startswith('__')]
    
    most_exp = df.loc[df['count'].idxmax()]
    print(f"Top Transcript: {most_exp['feature_id']} ({most_exp['count']})")

except Exception as e:
    print(e)
