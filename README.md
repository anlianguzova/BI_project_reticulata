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

[BBMap/BBTools](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbmap-guide/) (v. 39.01) was used for ID correction of short paired-end reads and filtering of rnaSPAdes results (removal of assembled sequences with unknown nucleotides). Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20).

### Short paired-end reads libraries quality control and preparation

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) (v. 0.12.1) was utilized to spot potential problems in sequencing datasets. 

[FastP utility](https://doi.org/10.1093/bioinformatics/bty560) (v. 0.23.2) performed the low-quality and adapter sequences removal. Scripts are available in the [repository](/Scripts/Host's%20ganglia%20transcriptome%20/Quality%20control%20and%20trimming%20).
The trimming parameters was the following: `--cut_window_size 4 --cut_mean_quality 20 --qualified_quality_phred 20 --length_required 25`.

### Decontamination of the datasets

[Kraken2](https://doi.org/10.1186/s13059-019-1891-0) (v. 2.1.2) is a taxonomic classification system using exact k-mer matches to achieve high accuracy and fast classification speeds. In our project, we used it to build a database of possible contamination (such as bacteria and viruses). The example of the script allowing to download database can be found [here](/Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/download_database).
In case of genomic short paired-end read libraries we used standard database that includes sequences libraries from archaea, viruses, bacteria, plasmid, fungi, human and protozoa. 
In case of transcriptomic short paired-end read libraries we added to standard database the early assembled transcriptome from the parasite *Peltogaster reticulata* ([Nesterenko, Miroliubov, 2023](https://f1000research.com/articles/11-583)) and the genomic sequences from another rhizocephalan species, *Sacculina carcini* ([Blaxter et al., *in press*](https://wellcomeopenresearch.org/articles/8-91)). *Sacculina carcini* [genome](https://www.ebi.ac.uk/ena/browser/view/GCA_916048095) was added using the command: `/home/LVP/Soft/kraken2/kraken2-build --add-to-library /home/LVP/Source/Sacculina/Sacculinacarcini_ref_genes.with_taxid.fasta --db /home/LVP/kraken2_db_females/Kraken2_plus_db_TEST --threads 10`

Database building was performed using the following [script](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/build_database/females_kraken_build_run.sh). 

Searching of the possible contaminants against constructed database was made using [the following scripts](Scripts/Host's%20ganglia%20transcriptome%20/Kraken2/search_database). The results were visualized by [Pavian](https://doi.org/10.1101/084715) (v. 1.0).

### Assembly 

#### Host's ganglia transcriptomes

We performed *de novo* transcriptome assembling using 3 tools (rnaSPAdes, RNA-Bloom, and Trinity) in order to receive the best results using the strengths of different assemblers. Before assemblying we merged all prepared short paired-end read libraries from healthy and infected female and male crabs into the single fastq files.  

##### rnaSPAdes

[rnaSPAdes](https://doi.org/10.1093/gigascience/giz100) (SPAdes v. 3.15.4) with default options was used. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/RNAspades/run_rnaspades.sh).

##### RNA-Bloom

[RNA-Bloom](https://doi.org/10.1101/gr.260174.119) (v. 2.0.1) was installed using mamba (v. 1.4.1). Specified options was `--kmer 25 --percent 0.90 --length 200`. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Rna-Bloom/run_rnabloom.sh).

##### Trinity 

[Trinity](https://doi.org/10.1038/nprot.2013.084) (v. 2.14.0) was utilised. We also installed the tool dependencies using conda (v. 23.1.0) into special virtual environment. The avaliable script is [here](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Trinity/new_trinity.sh).

##### Filtering transcriptome assembly results

In further analysis, we considered only sequences with a length of at least 200 nucleotides. To filter the assembly results, we used the [python script](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Length_filter.py) to the all obtained transcriptomic assemblies.

##### Transcriptome assemblies redundancy reduction via clusterization

[CD-HIT](https://doi.org/10.1093/bioinformatics/bts565) (v. 4.8.1) was used to the three transcriptome assemblies separate clusterization. Clusters with 95% identity were gathered comparing both strand (+/+, +/-). Clusterization was performed using the following [scripts](/Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Clusterization%20(CD-HIT)).

#### Parasite genome

##### Genome size assessment

[Jellyfish](https://doi.org/10.1093/bioinformatics/btr011) (v. 2.3.0) was run using the script available [here](Scripts/Genome/Jellyfish/run_jellyfish.sh). The calculations were performed for a k-mer length 25 bp (parameter `--mer-len=25`), and `--size=265M` parameter was taken based on the total size of the [_Sacculina_ genome](https://www.ebi.ac.uk/ena/browser/view/GCA_916048095) (264,490,643 bp). 

The outputs were analyzed using [GenomeScope](http://qb.cshl.edu/genomescope/) (v. 1.0). 

##### Generation of *in silico* mate pairs libraries using *S. carcini* genome as reference

*In silico* mate pair libraries were generated via [`Cross-species scaffolding`](https://github.com/thackl/cross-species-scaffolding) pipeline with `-l 141` prameter (the size of the smallest of the average length of the short paired-end reads). The other parameters were left default. This pipeline was run from [conda virtual environment](env).

##### *De novo* genome assembly

[SPAdes](https://doi.org/10.1093/gigascience/giz100) (v. 3.15.4) was used for *Peltogaster reticulata* genome assembly launching the script available [here](Scripts/Genome/SPAdes). The paths to the merged decontaminated fastq files and previously obtained *in silico* mate pair libraries were specified, and the assembly was done in careful mode (parameter `--careful`). 

### Assembly quality control

[TransRate](https://doi.org/10.1101/gr.196469.115) (v. 1.0.1) was utilised for the qualitative analysis of *de novo* transcriptome assemblies. The default options were used. The scripts for all assemblies can be found [here](Scripts/Host's%20ganglia%20transcriptome%20/TransRate). Only the sequences with high quality and assembly completeness (“good” according to the TransRate classification) were used in the following analysis.
Quality assessment of parasite genome assembly was obtained via [QUAST](https://cab.spbu.ru/software/quast/) (v. 5.2.0).

### Merging transcriptome assemblies into a single reference transcriptome

All the transcriptome contigs with high rates of quality and assembly completeness were merged using basic UNIX-commands. Transcriptome redundancy reduction was performed using 
[CD-HIT](https://doi.org/10.1093/bioinformatics/bts565) clusterization with minimal 95% identity between contigs and both strand comparison. The script is in this [folder](Scripts/Host's%20ganglia%20transcriptome%20/Assembly/Clusterization%20(CD-HIT)/whole%20assembly).

### Transcriptome assemblies completeness control

Benchmarking Universal Single-Copy Ortholog ([BUSCO](https://doi.org/10.1093/molbev/msab199)) (v. 5.4.7) was used for the transcriptome assemblies completeness control via the searching of metazoan single-copy orthologs. The transcriptome mode was selected (`-m transcriptome`), and Metazoa OrthoDB (v. 10) was used as lineage dataset. The scripts are available [here](/Scripts/Host's%20ganglia%20transcriptome%20/BUSCO). The Venn diagram visualization was created using [InteractiVenn](http://www.interactivenn.net/).

### Quantifying transcripts expression

[Salmon](https://doi.org/10.1038/nmeth.4197) (v. 1.10.1) installed in special conda environment mapped the short paired-end reads libraries to the reference transcriptome assembly. The script allowing to create an index for the reference transcriptome is avaliable [here](/Scripts/Host's%20ganglia%20transcriptome%20/Salmon/run_Pdum_good_contigs_salmon_index.sh). Mapping of the paired-end reads and the sequences expression quantification was performed using the [following script](Scripts/Host's%20ganglia%20transcriptome%20/Salmon/fem_quant.sh) for the data from the female hermit crabs and [this script](Scripts/Host's%20ganglia%20transcriptome%20/Salmon/male_quant.sh) for the males.  

### Determination of assembly translation products

[TransDecoder](https://github.com/TransDecoder/TransDecoder) (v. 5.5.0) identified candidate coding regions within transcript sequences. Initial identification of open reading frames (ORFs) and translation products was performed using [this script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_TransDecoder_LongORFs.sh).
[HMMER](https://doi.org/10.1093/bioinformatics/btt403) (v. 3.3.2) was used to compare found ORFs translation products with Pfam-A database using the [following script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_LongORFs_vs_PfamA.sh). Comparison of amino acid sequences with the UniRef90 database was performed using the [DIAMOND](https://www.crystalimpact.de/diamond/) (v. 2.0.15) program. The script is available [here](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_LongORFs_vs_UniRef90.sh).
Refinement of ORFs translation products was performed using the results of comparison with databases. The [script](/Scripts/Host's%20ganglia%20transcriptome%20/Transdecoder/run_Pdum_TransDecoder_Predict.sh) is provided.

### Reference set of protein-coding sequences

We selected transcripts encoding proteins consisting of more than 100 amino acids and with the expression level [more than 2 transcripts per million (TPM)](https://doi.org/10.1007/s12064-013-0178-3) (According to the Wagner, Kin & Lynch (2013) publication, “genes with more than two transcripts per million transcripts (TPM) are highly likely from actively transcribed genes.”) at least in one sample analysed using the [provided jyputer notebook](Scripts/Host's%20ganglia%20transcriptome%20/Final_fasta_sorting/Sort_assembly_expression_files.ipynb). 

### Protein-coding sequences functional annotation

[EggNOG-mapper](http://eggnog-mapper.embl.de) (v. 2.1.9) was used to annotate the obtained proteins. [EggNOG database](http://eggnog5.embl.de/#/app/home) contains information about the orthologs of various organisms, the participation of the sequences in the biological processes, and the presence of certain protein domains.

### Protein-coding sequences differential expression analysis

[RNentropy](https://academic.oup.com/nar/article/46/8/e46/4829696) was utilised for the detection of significant variation of protein-coding sequences expression. The analysis was conducted using R (v. 4.2.3), the scripts are in the [corresponding folder](Scripts/Host's%20ganglia%20transcriptome%20/Differential%20expression). The results obtained are in [another directory](Results/Differential%20expression).

### Gene Set Enrichment analysis (GSEA)

[GeneOntology](http://geneontology.org) (GO) terms enrichment analysis was performed for the lists of differentially expressed protein-coding sequences. In present analysis, we selected only biological processes with p-value less than 0.01 and with more than 10 sequences. The analysis was also performed in R using [topGO](https://doi.org/10.18129/B9.bioc.topGO), [rrvgo](https://doi.org/10.18129/B9.bioc.rrvgo), [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) packages and [ggplot2](https://cloud.r-project.org/web/packages/ggplot2/index.html), [wordcloud](https://cran.r-project.org/web/packages/wordcloud/index.html), [viridis](https://cran.r-project.org/web/packages/viridis/index.html) packages for visualization. We utilised *Drosophila melanogaster* [database](http://bioconductor.org/packages/release/data/annotation/html/org.Dm.eg.db.html) as the closest avaliable relative to the anomuran *Pagurus minutus* (Arthropoda: Tetraconata) to  simplify the redundance of GO sets by grouping similar terms based on their semantic similarity. All [R scripts](Scripts/Host's%20ganglia%20transcriptome%20/Differential%20expression) are avaliable in the repository.    
 
## Results 

### Transcriptome analysis

The following results were obtained to investigate the effect of rhizocephala infection on male and female hermit crabs.

#### Short paired-end reads libraries quality control and preparation

FastQC reports can be found in the [repository](Results/FastQC). The typical report file is present below.

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/fastqc_rep.png?raw=true" alt="Fastqc visualization"/>
</p>

FastP reports can be found in the [repository](Results/FastP).

| Sample | Total reads before filtering | Total reads after filtering | 
|----------|----------|----------|
| Healthy female 1   | 82.026308 M  |79.385246 M  | 
| Healthy male 1   |  85.496404 M  |83.758090 M  | 
| Healthy male 2  | 90.861836 M  |88.830500 M  | 
| Infected female 1 | 95.794892 M   |92.579908 M  |
| Infected female 2  | 85.876652 M   |83.779848 M |
| Infected male 1  | 98.179706 M  | 94.507014 M  |
| Infected male 2  | 81.547070 M |79.246654 M  |

#### Decontamination of the datasets

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

Results of the TransRate quality control analysis can be found in the [directory](Results/Transrate_output).

Here, we present the comparison of results obtained for different assemblers based on BUSCO analysis results. 

| Assembler      | Complete orthologs | Complete and single-copy orthologs | Complete and duplicated orthologs | Fragmented orthologs | Missing orthologs |
| -------------- | --------------- | ------------------------------- | ------------------------------ | ----------------- | -------------- |
| rnaSPAdes      | 949             | 245                             | 704                            | 2                 | 3              |
| RNA-Bloom      | 940             | 273                             | 667                            | 7                 | 7              |
| Trinity        | 933             | 232                             | 701                            | 12                | 9              |
| Whole assembly | 949             | 126                             | 823                            | 2                 | 3              |

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/Venn_diagram_assemblers.png?raw=true" alt="Venn diagram on metazoans orthologs from different assemblers"/>
</p>

#### Protein-coding sequences identification

Sets of sequences encoding proteins and having a significant level of expression in at least one sample, as well as tables with their levels of expression, are presented in the [directory](Results/Final%20fasta%20sorting).

#### Protein-coding sequences differential expression analysis and Gene Set Enrichment analysis results

RNentropy and GO-terms enrichment results are avaliable in the repository [directory](Results/Differential%20expression). Some visializations are present below.

##### Reduced Gene Set Enrichment analysis (GSEA) for the infected male hermit crabs

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/male_gsea.png?raw=true" alt="Gene Set Enrichment analysis (GSEA) for the infected male hermit crabs"/>
</p>

##### Word cloud visualization of processes reduced in infected males compared to non-parasitised ones

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/wordcloud_male_diff.png?raw=true" alt="Wordcloud with processes absent in infected males"/>
</p>

The illustration shows the biological processes that are absent in infected males compared to healthy ones. The letter size reflects the enrichment level of these bioprocesses in healthy individuals. The biological processes responsible for the regulation of the life cycle, cytokine and apoptotic pathways are suppressed in infected hosts.

Other illustrations can be found in the [repository](Results/Final%20fasta%20sorting), as well as on [the presentation with the report](https://docs.google.com/presentation/d/1fdvFlChGYvV4cWIo85fQBM66i9gYXkpvyZgR37IygLQ/edit#slide=id.g22528949c5a_53_66).

### Genome assembly

We have attempted to assembly the parasite genome to reveal genomic adaptations to parasitism in Rhizocephala. Assembling the genome of _P. reticulata_ is in progress: there are rooms for improvement.

#### Library preparation

FastP reports can be found in the [repository](Results/FastP).

| Library | Total reads before filtering | Total reads after filtering | 
|----------|----------|----------|
| Genome library 1  | 229.866546 M |225.786682 M  |
| Genome library 2  | 217.319394 M |213.272696 M  |
| Genome library 3  | 163.674608 M |160.788526 M |

#### Decontamination of the datasets

Pavian application visualized Kraken2 outputs. [Results](Results/Kraken2_pavian) are avaliable in the repository.

#### Genome size analysis results

Results can be found [here](Results/Jellyfish).

#### *In silico* mate pairs read libraries generation results

The following libraries were obtained:

| Insert length | Number of reads|
|----------|----------|
| 1000   | 8098  | 
| 1500   |  5031  | 
| 2000  | 4095  | 
| 5000 | 2808   |
| 10000  | 1187   |
| 20000  | 794  | 
| 50000  | 712  |
| 100000  | 737   |
| 200000  | 587  |

#### Quality control of the assembly

The QUAST results can be found in the [repository](Results/SPAdes_genome), and general summary is present below.

<p align="center">
<img src="https://github.com/anlianguzova/BI_project_reticulata/blob/main/Pics/quast_gen_res.PNG?raw=true" alt="Genome assembly general summary"/>
</p>

## Summary

### Summary of transcriptomic findings

1. Percentage of “good” contigs for Trinity, RNA-Bloom, rnaSPAdes was 59%, 74%, 95% respectively. 
2. We identified 97 biological processes that involve protein-coding sequences with a statistically significant change in expression between comparison pairs.
3. The differential expression analysis of protein-coding sequences included pairwise comparisons of infected and healthy host individuals, as well as individuals of different sexes. Both male and female infected hermit crabs tend to decrease in the number of active biological processes. Among the processes suppressed in infected hosts compared to healthy ones, we distinguished those responsible for the reproduction and ageing, as well as those involved in cytokine and apoptotic pathways and immunity regulation. The results obtained are consistent with data on parasitic castration and, in some cases, complete destruction of the gonads of infected hosts. The interna rootlets do not damage the host's reproductive tissues mechanically, so the suppression of the reproductive system may occur due to the initial inhibition of the processes associated with reproduction through changes in the nervous tissue.
4. Comparison of healthy males and females of _P. minutus_ showed significant differences in the number of molecular processes in the compared groups. It is notable that a small number of bioprocesses determine the difference in the transcriptomes of infected females and infected males. Thus, infection with _P. reticulata_, probably, smoothes, at the molecular level, the sex differences between the hermit crabs. Similar patterns were previously described at the morphological level: infection with peltogastrids leads to feminisation of males and hypofeminisation of females.

### Summary of genomic findings

1. The length of the total genome assembled by SPAdes is 361.6 Mb, which is higher than the values obtained for _Sacculina carcini_ (Rhizocephala: Sacculinidae) with genome size 264 Mb. 
2. Despite the high quality of the DNA-seq short paired-end reads libraries (more than 98% of read passed quality filters according to FastP), the current genome assembly is highly fragmented (N50 = 1292). We hypothesise that the differences between phylogenetically related species and complexity in genome _de novo_ assembling are due to the presence of a large repeats’ number observed previously in studies of the parasitic barnacles genomes. 
3. Further improvement in the quality of _P. reticulata_ genome assembly will be carried out using long ONT reads and the creation of more _in silico_ mate pair reads libraries.

We also provide a full description of the obtained results in the following [Google Slides presentation](https://docs.google.com/presentation/d/1fdvFlChGYvV4cWIo85fQBM66i9gYXkpvyZgR37IygLQ/edit#slide=id.g22528949c5a_53_66). 
All analysis steps with scripts and tools commands can also be found in the [Jupyter Notebooks](Jupyter_Notebooks).
