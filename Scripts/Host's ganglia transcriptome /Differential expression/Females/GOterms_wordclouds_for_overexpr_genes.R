### Libraries ###
library(wordcloud)
library(dplyr)
library(viridis)

### Input files ###
infected_reduced <- read.csv2("Pmin_Infected_fem_overexpr_genes_reduced_GSEA_results.Dmelanogaster.tsv", 
                             header = T, sep="\t")
healthy_reduced <- read.csv2("Pmin_Healthy_fem_overexpr_genes_reduced_GSEA_results.Dmelanogaster.tsv", 
                              header = T, sep="\t")
species_tag <- "Pmin"
set_tag <- "over-expressed_genes"

set.seed(1234)

### Processing ###
input_list <- list("infected_fem" = infected_reduced,
                   "healthy_fem" = healthy_reduced)

for (set in 1:length(input_list)){
  set_reduced_terms <- count(input_list[[set]], input_list[[set]]["parentTerm"], sort=T)
  colnames(set_reduced_terms) <- c("word", "freq")
  viridis_colors <- viridis(n = length(set_reduced_terms$word))
  # visual #
  pdf(file=sprintf("%s_%s_%s.wordcloud.pdf", species_tag, names(input_list[set]), set_tag), width = 9, height = 9)
  set_reduced_term_cloud <- wordcloud(words=set_reduced_terms$word, freq=set_reduced_terms$freq, min.freq = 1, 
                                      max.words=length(set_reduced_terms$word), scale = c(4.25, 0.25),
                                      random.order = F, rot.per = 0, colors = as.character(viridis_colors), ordered.colors = T)
  dev.off()
}
