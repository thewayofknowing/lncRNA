setwd("~/UniBe/HS2021/RNA Seq")

library(sleuth)

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


mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                         dataset = "hsapiens_gene_ensembl",
                         host = 'ensembl.org')
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id",
                                     "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id,
                     ens_gene = ensembl_gene_id, ext_gene = external_gene_name)

run_sleuth('experiment', TRUE)

