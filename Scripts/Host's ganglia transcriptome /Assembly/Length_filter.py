try:
    import argparse
except ImportError:
    print("Please check if module 'argparse' is installed")
    quit()

from Bio import SeqIO

parser = argparse.ArgumentParser()
parser.add_argument('--fasta', type=argparse.FileType('r'), required=True)
parser.add_argument('--min_len', type=str, required=True)
parser.add_argument('--out', type=str, required=True)
args = parser.parse_args()


if __name__ == "__main__":
    fasta_seqs = SeqIO.parse(args.fasta, "fasta")
    with open("{output}.fasta".format(output=args.out), 'a') as output:
        for fasta in fasta_seqs:
            name, sequence = fasta.id, fasta.seq
            if len(sequence) >= int(args.min_len):
                output.write(">{name}\n{seq}\n".format(name=name, seq=sequence))
