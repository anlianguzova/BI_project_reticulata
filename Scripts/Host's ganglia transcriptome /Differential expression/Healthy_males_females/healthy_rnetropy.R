### Libraries ###
library(RNentropy)
library(dplyr)

### Input data ###
expr_unaveraged <- read.csv2("new_expression_data.csv", 
                             header = T, sep=",", row.names = 1)
expr_averaged <- read.csv2("new_mean_expression_data.csv", 
                           header = T, sep=",", row.names = 1)
colnames(expr_unaveraged) <- c("Im_12", "If_11", 
                               "Hm_2", "If_3", "Im_4", 
                               "Hm_10", "Hf_1")
Healthy_fem <- c(1, 0, 0)
Healthy_male <- c(0, 1, 1)
Sample <- c("Hf_1", "Hm_10", "Hm_2")  
design_matrix <- data.frame(Sample, Healthy_fem, Healthy_male)
rownames(design_matrix) <- Sample
design_matrix <- design_matrix[, c(2, 3)]
species_tag <- "Pmin"

# Mutate #

expr_healthy <- expr_unaveraged %>% select(all_of(Sample)) 
expr_healthy <- mutate_all(expr_healthy, function(x) as.numeric(as.character(x)))
expr_healthy$GeneIDs <- as.factor(rownames(expr_healthy))
design_matrix <- data.matrix(design_matrix, rownames.force = T)

### Analysis ###
# compute statistics and p-values
RNresults <- RN_calc(expr_healthy, design = design_matrix)
# select only genes with significant changes of expression
# select sequences with global p-value lower than an user defined threshold 
# and provide a summary of over- and under-expression accoding to local p-values
RNresults_selected <- RN_select(RNresults, gpv_t = 0.01, 
                                lpv_t = 0.01, method = 'BH')
######
# NB! Был добавлен новый df - selected:
# Transcripts/genes with a corrected global p-value lower than gpv_t. 
# For each condition it will contain a column where values can be -1,0,1 or NA. 
# 1 means that all the replicates of this condition have expression value higher than the
# average and local p-value <= lpv_t (thus the corresponding gene will be over-expressed in this condition). 
# -1 means that all the replicates of this condition have expression value lower than the average and local p-value <= lpv_t (thus
# the corresponding gene will be under-expressed in this condition). 
# 0 means that at least one of the replicates has a local p-value > lpv_t. 
# NA means that the local p-values of the replicates are not consistent for this condition, that is, at least
# one replicate results to be over-expressed and at least one results to be under-expressed.
#######
RNresults_significant <- RNresults_selected$selected
write.table(RNresults_significant, 
            file=sprintf("%s_RNentropy_significant_results.tsv", species_tag),
            sep="\t", col.names = T, row.names = F)

### Subset over-expressed genes only ###
colnames(RNresults_significant)

for (sample in c("Healthy_fem", "Healthy_male")){
  sample_overexpr <- subset(RNresults_significant, 
                            RNresults_significant[[sample]] == "1")
  write.table(sample_overexpr, file=sprintf("%s_%s_RNentropy_overexp.tsv", 
                                            species_tag, sample),  sep="\t", 
              col.names = T, row.names = F)
}

### Compute point mutual information matrix for the experimental conditions ###
RNresults_pmi <- RN_pmi(RNresults)
RNresults_npmi_matrix <- RNresults_pmi$npmi
write.table(RNresults_npmi_matrix, file=sprintf("%s_RNentropy_npmi.tsv", 
                                                species_tag), sep="\t", 
            col.names = T, row.names = T)
