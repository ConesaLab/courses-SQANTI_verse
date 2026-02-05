import argparse
import sys

def filter_gtf(input_file, output_file, chromosomes):
    """
    Filters a GTF file to keep only entries belonging to specific chromosomes.
    """
    allowed_chroms = set(chromosomes)
    
    try:
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            count = 0
            kept = 0
            for line in infile:
                if line.strip().startswith('#'):
                    outfile.write(line)
                    continue
                
                parts = line.split('\t')
                if len(parts) < 1:
                    continue
                
                chrom = parts[0]
                if chrom in allowed_chroms:
                    outfile.write(line)
                    kept += 1
                count += 1
                
        print(f"Processed {input_file}. Keeping chromosomes: {', '.join(chromosomes)}")
        print(f"Total data lines: {count}. Kept lines: {kept}. Saved to {output_file}.")
        
    except IOError as e:
        print(f"Error reading or writing files: {e}")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Filter GTF file by chromosome.")
    parser.add_argument("input_gtf", help="Path to the input GTF file")
    parser.add_argument("output_gtf", help="Path to the output GTF file")
    parser.add_argument("-c", "--chromosomes", nargs='+', required=True, help="List of chromosomes to keep (e.g., chr19 19 chrX)")
    
    args = parser.parse_args()
    
    filter_gtf(args.input_gtf, args.output_gtf, args.chromosomes)

if __name__ == "__main__":
    main()
