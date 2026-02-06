import sys
import re
import argparse
import os

def process_gtf(input_file, output_file):
    """
    Removes '.19.nnic' from the transcript_id attribute in a GTF file.
    """
    
    # We want to match: transcript_id "SOME_ID.19.nnic"
    # and replace it with: transcript_id "SOME_ID"
    #
    # Explanation of regex:
    # (transcript_id\s+"[^"]+)  -> Group 1: Matches 'transcript_id "' followed by characters that are not quotes
    # \.19\.nnic"               -> Matches literal '.19.nnic"'
    #
    # Replacement: \1" Match group 1 + closing quote
    
    pattern = re.compile(r'(transcript_id\s+"[^"]+)\.19\.nnic"')

    try:
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            count = 0
            for line in infile:
                if line.strip().startswith('#'):
                    outfile.write(line)
                    continue
                
                # Check if the line likely contains the pattern before applying regex (speed optimization)
                if '.19.nnic' in line:
                    new_line, num_subs = pattern.subn(r'\1"', line)
                    if num_subs > 0:
                        count += num_subs
                    outfile.write(new_line)
                else:
                    outfile.write(line)
        
        print(f"Processed {input_file}. Modified {count} transcript_id entries. Saved to {output_file}.")
        
    except IOError as e:
        print(f"Error reading or writing files: {e}")
        sys.exit(1)

def process_abundance(input_file, output_file):
    """
    Removes '.19.nnic' from the feature_id column in the abundance table (TSV file).
    """
    
    try:
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            count = 0
            for line in infile:
                # Keep header line as-is
                if line.startswith('#'):
                    outfile.write(line)
                    continue
                
                # Process data lines - remove .19.nnic from the first column
                if '.19.nnic' in line:
                    new_line = line.replace('.19.nnic', '')
                    count += 1
                    outfile.write(new_line)
                else:
                    outfile.write(line)
        
        print(f"Processed {input_file}. Modified {count} feature_id entries. Saved to {output_file}.")
        
    except IOError as e:
        print(f"Error reading or writing files: {e}")
        sys.exit(1)

def insert_clean_suffix(filename):
    """
    Inserts '.clean.' before the file extension.
    Example: 'file.gtf' -> 'file.clean.gtf'
             'file.txt.gz' -> 'file.clean.txt.gz'
    """
    base, ext = os.path.splitext(filename)
    return f"{base}.clean{ext}"

def main():
    parser = argparse.ArgumentParser(description="Remove '.19.nnic' suffix from transcript_ids in GTF and abundance files.")
    parser.add_argument("-g", "--input_gtf", help="Path to the input GTF file")
    parser.add_argument("-a", "--input_abundance", help="Path to the input abundance table (TSV file)")
    parser.add_argument("-o", "--output_dir", help="Directory where output files will be saved")
    
    args = parser.parse_args()
    
    # Create output directory if it doesn't exist
    os.makedirs(args.output_dir, exist_ok=True)
    
    # Generate output filenames with '.clean.' inserted before extension
    gtf_basename = os.path.basename(args.input_gtf)
    abundance_basename = os.path.basename(args.input_abundance)
    
    output_gtf = os.path.join(args.output_dir, insert_clean_suffix(gtf_basename))
    output_abundance = os.path.join(args.output_dir, insert_clean_suffix(abundance_basename))
    
    # Process both files
    process_gtf(args.input_gtf, output_gtf)
    process_abundance(args.input_abundance, output_abundance)

if __name__ == "__main__":
    main()
