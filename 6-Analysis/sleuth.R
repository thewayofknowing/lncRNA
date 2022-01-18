setwd("~/UniBe/HS2021/RNA Seq")

library(sleuth)

run_wt <- function(so, coeff) {
  oe <- sleuth_wt(so, which_beta = coeff)

  sleuth_table <- sleuth_results(oe, test=coeff, show_all = FALSE)
  sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)
  write.table(sleuth_significant, file = paste('sleuth_data/', experiment_name, '_', coeff, '.table.tsv', sep=''), 
              sep='\t', row.names = FALSE, quote = FALSE)
}

run_sleuth <- function(experiment_name) {
  experiment_filename <- paste('sleuth_data/', experiment_name, '.txt', sep='')
  s2c <- read.table(file.path(experiment_filename), header = TRUE, stringsAsFactors = FALSE)
  s2c <- dplyr::select(s2c, sample, condition, path)
  
  so <- sleuth_prep(s2c, target_mapping = t2g, extra_bootstrap_summary = TRUE, transformation_function = function(x) log2(x + 0.5))
  so <- sleuth_fit(so, ~condition)
  sleuth_save(so, file = paste('sleuth_data/', experiment_name, '.so.model', sep=''))

  run_wt(so, 'conditionparaclone')
  run_wt(so, 'conditionholoclone')
  run_wt(so, 'conditionmeroclone')
}

run_sleuth('experiment')

