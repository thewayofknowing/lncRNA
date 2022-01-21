setwd("~/UniBe/HS2021/RNA Seq")

library(sleuth)
library(dplyr)

run_wt <- function(so, coeff, gene_mode = FALSE) {
  oe <- sleuth_wt(so, which_beta = coeff)

  if (gene_mode) {
    filename <- file = paste('sleuth_data/', experiment_name, '_', coeff, '.gene.table.tsv', sep='')
  }
  else {
    filename <- file = paste('sleuth_data/', experiment_name, '_', coeff, '.table.tsv', sep='')
  }
  sleuth_table <- sleuth_results(oe, test=coeff, show_all = FALSE)
  sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)
  write.table(sleuth_significant, filename,  
              sep='\t', row.names = FALSE, quote = FALSE)
}

run_sleuth <- function(experiment_name, gene_mode = FALSE) {
  experiment_filename <- paste('sleuth_data/', experiment_name, '.txt', sep='')
  s2c <- read.table(file.path(experiment_filename), header = TRUE, stringsAsFactors = FALSE)
  s2c <- dplyr::select(s2c, sample, condition, path)
  
  if (gene_mode) {
    so <- sleuth_prep(s2c, target_mapping = t2g, aggregation_column = 'ens_gene', gene_mode = TRUE, extra_bootstrap_summary = TRUE, transformation_function = function(x) log2(x + 0.5))
    model_name <- paste('sleuth_data/', experiment_name, '.so.gene.model',  sep='')
  }
  else {
    so <- sleuth_prep(s2c, target_mapping = t2g, extra_bootstrap_summary = TRUE, transformation_function = function(x) log2(x + 0.5))
    model_name <- paste('sleuth_data/', experiment_name, '.so.model', sep='')
  }
  so <- sleuth_fit(so, ~condition)
  sleuth_save(so, file = model_name)

  run_wt(so, 'conditionparaclone')
  run_wt(so, 'conditionholoclone')
  run_wt(so, 'conditionmeroclone')
}


t2g <- read.table('lncRNA/3-Transcriptome/pretty_merged_gtf.tsv', header = TRUE)
t2g <- t2g[t2g$type=='transcript',]
t2g <- unique(t2g %>% select(transcript_id, gene_id, ref_gene_id, gene_name))
t2g <- t2g %>% rename(target_id = transcript_id, ens_gene = ref_gene_id)


run_sleuth('experiment', TRUE)

