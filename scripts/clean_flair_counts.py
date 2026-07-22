import sys
import re

def clean_flair_counts(gtf_file, counts_file, output_file):
    gtf_ids = set()
    with open(gtf_file) as f:
        for line in f:
            m = re.search(r'transcript_id "([^"]+)"', line)
            if m:
                gtf_ids.add(m.group(1))

    with open(counts_file) as infile, open(output_file, 'w') as outfile:
        outfile.write("pbid\tcount\n")
        for line in infile:
            parts = line.strip().split('\t')
            if len(parts) == 2:
                raw_id, count = parts[0], parts[1]
                if raw_id in gtf_ids:
                    outfile.write(f"{raw_id}\t{count}\n")
                else:
                    stripped = raw_id.rsplit('_', 1)[0]
                    if stripped in gtf_ids:
                        outfile.write(f"{stripped}\t{count}\n")
                    else:
                        outfile.write(f"{raw_id}\t{count}\n")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python clean_flair_counts.py <gtf> <flair_counts_txt> <output_tsv>")
        sys.exit(1)
    clean_flair_counts(sys.argv[1], sys.argv[2], sys.argv[3])
