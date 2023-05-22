# Bioinformatics Institute project "Comparative transcriptomic analysis of the abdominal ganglia of the hermit crab *Pagurus minutus*, healthy and infected with *Peltogaster reticulata* ("Crustacea": Rhizocephala)"

## Authors

- Elizaveta Gafarova
- Darya Golofeeva
- Anastasia Lianguzova

## Supervisors

- Maksim Nesterenko
- Aleksei Miroliubov

## Abstract

Rhizocephala ("Crustacea": Cirripedia) are singular and highly specialised obligate endoparasites. Profound adaptations to the endoparasitic lifestyle have affected many aspects of the rhizocephalan biology. The gross morphology, physiology and life cycles of these parasites have undergone strong modification. Despite significant morphological simplifications, rhizocephalans have gained a number of specific regulatory mechanisms allowing them to take control of the host body. Parasitic barnacles are capable of modifying the morphology, hormonal and physiological status, as well as the behaviour of the infected host. The specialised rhizocephalan rootlets penetrating the host's ganglia have a significant role in the interaction between the parasite and the host.
The rapid development of high-throughput sequencing technologies has made it possible to study in detail the molecular basis of host-parasite interplay. However, to date, no molecular data relating to the interactions of basal family rhizocephalans with their hermit crab hosts are publicly available. 
The aim of this project is to conduct a comparative transcriptomic analysis of the ganglia of male and female *Pagurus minutus* hermit crab, both healthy and infected with the rhizocephalan *Peltogaster reticulata*. We have also attempted to assembly the parasite genome to reveal genomic adaptations to parasitism in Rhizocephala. 

## Methods

### Data reformatting

BBMap/BBTools (v. 39.01) was used for ID correction of reads and filtering of rnaSPAdes results. Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20). 

### Quality control and library preparation

FastQC (v. 0.12.1) was utilized to spot potential problems in sequencing datasets. 

FastP utility (v. 0.23.2) performed the low-quality and adapter sequences removal. Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20).
The trimming parameters was the following: `--cut_window_size 4 --cut_mean_quality 20 --qualified_quality_phred 20 --length_required 25`.

### Decontamination of the datasets

Kraken2 (v. 2.1.2) is a taxonomic sequence classification system that provides an opportunity to build database of possible contaminations (such as bacteria and viruses). The example of the script allowing to download database can be found [here](/Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/download_database). 
In case of filtered genome sequences we used standard database that includes libraries from archaea, viruses, bacteria, plasmid, fungi, human and protozoa. 
In case of transcriptomic sequences we added to standard database the early assembled transcriptomic data from the parasite *Peltogaster reticulata* ([Nesterenko, Miroliubov, 2023](https://f1000research.com/articles/11-583)) and the genomic sequences from another rhizocephalan species, *Sacculina carcini* ([Blaxter et al., *in press*](https://wellcomeopenresearch.org/articles/8-91)). *Sacculina carcini* genome was added using the command: `/home/LVP/Soft/kraken2/kraken2-build --add-to-library /home/LVP/Source/Sacculina/Sacculinacarcini_ref_genes.with_taxid.fasta --db /home/LVP/kraken2_db_females/Kraken2_plus_db_TEST --threads 10`

Database building was performed using the following [script](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/build_database/females_kraken_build_run.sh). 

Searching of the possible contaminants against constructed database was made using [the following scripts](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/search_database). The results were visualized by Pavian (v. 1.0).

### Assembly 

#### Host's ganglia transcriptomes

We performed *de novo* transcriptome assembly using 3 tools (rnaSPAdes, RNA-Bloom, and Trinity) in order to receive the best results using the strengths of different assemblers. Before assemblying we merged all prepared read libraries from healthy and infected female and male crabs into the fastq files.  

##### rnaSPAdes

rnaSPAdes (SPAdes v. 3.15.4) with default options was used. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/RNAspades/run_rnaspades.sh).

##### RNA-Bloom

RNA-Bloom (v. 2.0.1) was installed using mamba (v. 1.4.1). Specified options was `--kmer 25 --percent 0.90 --length 200`. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Rna-Bloom/run_rnabloom.sh).

##### Trinity 

Trinity (v. 2.14.0) was utilised. We also installed the tool dependecies using conda (v. 23.1.0) virtual environment. The avaliable script is [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Trinity/new_trinity.sh).

#### Parasite genome

##### Genome size assessment

Jellyfish (v. 2.3.0) was run using the script available [here](https://github.com/anlianguzova/BI_project_reticulata/blob/main/Scripts/Genome/Jellyfish/run_jellyfish.sh). The calculations were performed for a k-mer length 25 bp (parameter `--mer-len=25`). `--size=265M` parameter was taken based on the total size of the [_Sacculina_ genome](https://www.ebi.ac.uk/ena/browser/view/GCA_916048095) (264,490,643 bp). 

The outputs were analyzed using [GenomeScope](http://qb.cshl.edu/genomescope/) (v. 1.0). 

##### Creating *in silico* mate pairs liabraries using *S. carcini* genome as reference

*In silico* mate pair libraries were made via [`Cross-species scaffolding`](https://github.com/thackl/cross-species-scaffolding) pipeline with `-l 141` prameter (the size of the smallest of the average length of the reads). The other parameters were left default. 

##### *De novo* genome assembly

SPAdes (v. 3.15.4) was used for *Peltogaster reticulata* genome assembly launching the script available [here](https://github.com/anlianguzova/BI_project_reticulata/tree/main/Scripts/Genome/SPAdes). The paths to the merged decontaminated fastq files and previously obtained *in silico* mate pair libraries were specified, and the assembly was done in careful mode (parameter `--careful`). 
Quality assessment was obtained via `Quast v. 5.2.0`.

##### Filtering assembly results

In order to get the sequencies with minimun length 200 nucletides we applied the [python script](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Length_filter.py) to the obtained transcriptomic assemblies. 

##### Redundancy reduction via clusterization

CD-HIT (v. 4.8.1) was used to the three assemblies separate clusterization. Clusters with 95% identity were gathered comparing both strand (++, +-). Clusterization was performed using the following [scripts](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Clusterization%20(CD-HIT)).

### Assembly quality control

TransRate (v. 1.0.1) was utilised for the qualitative analysis of *de novo* transcriptome assemblies. The default options were used; the scripts for all assemblies can be found [here](Scripts/Host's%20ganglia%20transcriptome%20/TransRate). Only the sequences with high quality and assembly completeness (“good” according to the TransRate classification) were used in the following analysis.

### Creating of the merged assembly

All the contigs with high rates of quality and assembly completeness were merged using basic UNIX-commands.

### Clusterization

CD-HIT (v. 4.8.1) clusterization was repeated on the merged contigs (95% identity, both strand comparison). The script is in this [folder](Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Clusterization%20(CD-HIT)/whole%20assembly).

### Quality control in good contigs sequences

BUSCO (v. 5.4.7) performed the searching of single-copy orthologs in the obtained assemblies. The transcriptome mode was selected (`-m transcriptome`), and Metazoa OrthoDB (v. 10) was used as lineage dataset. The scripts are available [here](/Scripts/Host's%20ganglia%20transcriptome%20/BUSCO). The Venn diagram visualization was created using [InteractiVenn](http://www.interactivenn.net/).

### Quantifying transcripts expression

Salmon (v. 1.10.1) installed in conda environment mapped the short reads libraries to the assembled sequences. The obtained values were filtred due to the sequencing depth and the contig size in order to obtain a numerical value of the expression level. The script allowing to create an index for the obtained sequences is avaliable [here](/Scripts/Host's%20ganglia%20transcriptome%20/Salmon/run_Pdum_good_contigs_salmon_index.sh). Mapping of the sequences and the expression quantification was performed using the [following script](Scripts/Host's%20ganglia%20transcriptome%20/Salmon/fem_quant.sh) for the data from the female hermit crabs and [this script](Scripts/Host's%20ganglia%20transcriptome%20/Salmon/male_quant.sh) for the males.  

### Determination of assembly translation products

TransDecoder (v. 5.5.0) identified candidate coding regions within transcript sequences. Initial determination of open reading frames (ORFs) and translation products was performed using [this script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_LongORFs_vs_UniRef90.sh). 
HMMER (v. 3.3.2) was used to compare found ORFs translation products with Pfam-A database using the [following script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_LongORFs_vs_PfamA.sh).
DIAMOND (v. 2.0.15) performed to search ORFs translation products analysing Uniref90 database. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_LongORFs_vs_UniRef90.sh).
Final definition of ORFs was obtained through comparison of all this results using TransDecoder. The [script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_TransDecoder_Predict.sh) for prediction is provided. 

### Reference set of protein-coding sequences

We selected transcripts encoding proteins consisting of more than 100 amino acids and with the expression level more than 2 transcripts per million (TPM) at least in one sample analysed using the [provided jyputer notebook](Scripts/Host's%20ganglia%20transcriptome%20/Final_fasta_sorting/Sort_assembly_expression_files.ipynb). 

### Functional annotation

EggNOG-mapper (v. 2.1.9) was used to annotate the obtained proteins. EggNOG database contains information about the orthologs of various organisms, the participation of the sequences in the biological processes, and the presence of certain protein domains. 

### Differential expression analysis

[RNentropy](https://academic.oup.com/nar/article/46/8/e46/4829696) was utilised for the detection of significant variation of gene expression. The analysis was conducted using R (v. 4.2.3), the scripts are in the [corresponding folder](Scripts/Host's%20ganglia%20transcriptome%20/Differential%20expression). The binary presence/absence matrices are in [another directory](Results/Differential%20expression).

### Enrichment analysis

GeneOntology terms enrichment analysis was performed for the lists of differentially expressed genes. We utilised *Drosophila melanogaster* database as the closest avaliable relative to the anomuran *Pagurus minutus* (Arthropoda: Tetraconata) and the results from functional annotation. In present analysis, we selected only biological processes with p-value less than 0.01 and with more than 10 sequences. The analysis was also performed in R using `topGO`, `rrvgo`, `dplyr` packages and `ggplot2`, `wordcloud`, `viridis` packages for visualization. All [R scripts](Scripts/Host's%20ganglia%20transcriptome%20/Differential%20expression) are avaliable in the repository.    
 
## Results 

### Transcriptome analysis

#### Quality control

FastQC reports can be found in the [repository](Results/FastQC). The typical report file is present below.

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/fastqc_rep.png?raw=true" alt="Fastqc visualization"/>
</p>

### Library preparation

FastP reports can be found in the [repository](Results/FastP).

| Sample | Total reads before filtering | Total reads after filtering | 
|----------|----------|----------|
|Healthy female 1   | 82.026308 M  |79.385246 M  | 
|Healthy male 1   |  85.496404 M  |83.758090 M  | 
|Healthy male 2  | 90.861836 M  |88.830500 M  | 
| Infected female 1 | 95.794892 M   |92.579908 M  |
| Infected female 2  | 85.876652 M   |83.779848 M |
| Infected male 1  | 98.179706 M  | 94.507014 M  |
| Infected male 2  | 81.547070 M |79.246654 M  |
| Genome sample 1  | 229.866546 M |225.786682 M  |
| Genome sample 2  | 217.319394 M |213.272696 M  |
| Genome sample 3  | 163.674608 M |160.788526 M |


#### Decontamination 

Pavian application visualized Kraken2 outputs. [Results](Results/Kraken2_pavian) are avaliable in the repository. Demonstrative results are below.

##### Non-infected hermit crab

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/healthy_pavian.png?raw=true" alt="Pavian visualization of non-infected crab Kraken2 outputs"/>
</p>

##### Parasitised by *Peltogaster reticulata* 
<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/infected_pavian.png?raw=true" alt="Pavian visualization of infected crab Kraken2 outputs"/>
</p>

#### Quality control of different assembliers results

Result of the TransRate quality analysis can be found in the [directory](Results/Transrate_output).

Here, we present the comparison of results obtained by different assemblers based on found single-copy metazoan orthologs (BUSCO). 

| Assembler      | Complete BUSCOs | Complete and single-copy BUSCOs | Complete and duplicated BUSCOs | Fragmented BUSCOs | Missing BUSCOs |
| -------------- | --------------- | ------------------------------- | ------------------------------ | ----------------- | -------------- |
| rnaSPAdes      | 949             | 245                             | 704                            | 2                 | 3              |
| Rna-Bloom      | 940             | 273                             | 667                            | 7                 | 7              |
| Trinity        | 933             | 232                             | 701                            | 12                | 9              |
| Whole assembly | 949             | 126                             | 823                            | 2                 | 3              |

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/Venn_diagram_assemblers.png?raw=true" alt="Venn diagram on metazoans orthologs from different assemblers"/>
</p>

#### Protein-coding genes detection

Final expression-level (TPM) tables and fasta-files containing sequences with more than 100 amino acids and significant expression level are present in the [repository](Results/Final%20fasta%20sorting).

#### Differential expression results

RNetropy and enrichment results are avaliable in the repository [directory](Results/Differential%20expression). Some visializations are present below.

##### Reduced Gene Set Enrichment analysis (GSEA) for the infected male hermit crabs

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/male_gsea.png?raw=true" alt="Gene Set Enrichment analysis (GSEA) for the infected male hermit crabs"/>
</p>

##### Word cloud visualization of processes reduced in infected males compared to non-parasitised ones

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/wordcloud_male_diff.png?raw=true" alt="Wordcloud with processes absent in infected males"/>
</p>

The illustration shows the processes that are absent in infected males compared to healthy ones. The letter size reflects the enrichment level of these processes in healthy individuals. The processes responsible for the regulation of the life cycle, cytokine and apoptotic pathways are suppressed in infected hosts.

### Genome assembly

#### Genome size analysis

Results can be found [here](https://github.com/anlianguzova/BI_project_reticulata/tree/main/Results/Jellyfish).

#### *In silico* mate pairs libraries

The following libraries were obtained:

| Insert length | Number of reads|
|----------|----------|
|1000   | 8098  | 
|1500   |  5031  | 
|2000  | 4095  | 
| 5000 | 2808   |
| 10000  | 1187   |
| 20000  | 794  | 
| 50000  | 712  |
| 100000  | 737   |
| 200000  | 587  |

#### Quality control of the assembly

The Quast results can be found in the [repository](https://github.com/anlianguzova/BI_project_reticulata/tree/main/Results/SPAdes_genome).

We also provide a full description of the obtained results in the following Google Slides presentation. 
