# Bioinformatics Institute project "Comparative transcriptomic analysis of the abdominal ganglia of the hermit crab *Pagurus minutus*, healthy and infected with *Peltogaster reticulata* ("Crustacea": Rhizocephala)"

Rhizocephala ("Crustacea": Cirripedia) are singular and highly specialised obligate endoparasites. Profound adaptations to the endoparasitic lifestyle have affected many aspects of the rhizocephalan biology. The gross morphology, physiology and life cycles of these parasites have undergone strong modification. Despite significant morphological simplifications, rhizocephalans have gained a number of specific regulatory mechanisms allowing them to take control of the host body. Parasitic barnacles are capable of modifying the morphology, hormonal and physiological status, as well as the behaviour of the infected host. The specialised rhizocephalan rootlets penetrating the host's ganglia have a significant role in the interaction between the parasite and the host.
The rapid development of high-throughput sequencing technologies has made it possible to study in detail the molecular basis of host-parasite interplay. However, to date, no molecular data relating to the interactions of basal family rhizocephalans with their hermit crab hosts are publicly available. 
The aim of this project is to conduct a comparative transcriptomic analysis of the ganglia of male and female *Pagurus minutus* hermit crab, both healthy and infected with the rhizocephalan *Peltogaster reticulata*. We have also attempted to assembly the parasite genome to reveal genomic adaptations to parasitism in Rhizocephala. 

## Methods

### Data reformatting

BBMap/BBTools (v. 39.01) was used for ID correction of reads and filtering of rnaSPAdes results. Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20). 

### Quality control 

FastQC (v. 0.12.1) was utilized to spot potential problems in sequencing datasets. 

FastP utility (v. 0.23.2) performed the sequiencing filtering. Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20).
The trimming parameters was the following: `--cut_window_size 4 --cut_mean_quality 20 --qualified_quality_phred 20 --length_required 25`.

### Decontamination of the datasets

Kraken2 (v. 2.1.2) is a taxonomic sequence classification system that provides an opportunity to build database of possible contaminations (such as bacteria and viruses). The example of the script allowing to download database can be found [here](/Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/download_database). 
In case of filtered genome sequences we used standard database that includes library from archaea, viruses, bacteria, plasmid, fungi, human and protozoa contaminations. 
In case of transcriptomic sequences we added to standard database the early assembled transcriptomic data from the parasite *Peltogaster reticulata* (NCBI #2664287) and the genomic sequences from another rhizocephalan species, *Sacculina carcini* (NCBI #51650).

Database building was performed using the following [script](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/download_database/females_Kraken2_standard_db_download.sh).

Searching of the possible contaminants against build databse was made using [the following scripts](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/search_database). 

### Assembly 

#### Host's ganglia transcriptomes

We performed *de novo* assembly using 3 tools in order to receive the best results using the strengths of different assemblers. Before assemblying we created the single fasta file containing sequences from healthy and infected female and male crabs.  

##### rnaSPAdes

rnaSPAdes (SPAdes v. 3.15.4) with default options was used. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/RNAspades/run_rnaspades.sh).

##### Rna-Bloom

Rna-Bloom (v. 2.0.1) was installed using mamba (v. 1.4.1). Specified options was `--kmer 25 --percent 0.90 --length 200`. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Rna-Bloom/run_rnabloom.sh).

##### Trinity 

Trinity (v. 2.14.0) was utilised. We also installed the tool dependecies using conda (23.1.0) virtual environment and Trinity v. 2.13.2. The avaliable script is [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Trinity/new_trinity.sh).

### Filtering assembly results

In order to get the sequencies with minimun length 200 nucletides we applied the [python script](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Length_filter.py) to the obtained assemblies. 

#### Parasite genome

##### SPAdes

SPAdes v. 3.15.4

## Results 

#### BUSCO (single-copy orthologs)

| Assembler      | Complete BUSCOs | Complete and single-copy BUSCOs | Complete and duplicated BUSCOs | Fragmented BUSCOs | Missing BUSCOs |
| -------------- | --------------- | ------------------------------- | ------------------------------ | ----------------- | -------------- |
| rnaSPAdes      | 949             | 245                             | 704                            | 2                 | 3              |
| Rna-Bloom      | 940             | 273                             | 667                            | 7                 | 7              |
| Trinity        | 933             | 232                             | 701                            | 12                | 9              |
| Whole assembly | 949             | 126                             | 823                            | 2                 | 3              |

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/Venn_diagram_assemblers.png?raw=true" alt="Venn diagram on metazoans orthologs from different assemblers"/>
</p>

## Genome assembly

### Methods

### Results
