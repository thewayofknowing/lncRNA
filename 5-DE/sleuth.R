setwd("~/UniBe/HS2021/RNA Seq")

library(sleuth)

run_sleuth <- function(experiment_name) {
  experiment_filename <- paste('sleuth_data/', experiment_name, '.txt', sep='')
  s2c <- read.table(file.path(experiment_filename), header = TRUE, stringsAsFactors = FALSE)
  s2c <- dplyr::select(s2c, sample, condition, path)
  
  so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE)
  so <- sleuth_fit(so, ~condition, 'full')
#  so <- sleuth_fit(so, ~1, 'reduced')
#  so <- sleuth_lrt(so, 'reduced', 'full')
  sleuth_save(so, file = paste('sleuth_data/', experiment_name, '.so.model', sep=''))

  oe <- sleuth_wt(so, which_beta = 'conditionparent')
  
  plot_sample_heatmap(oe)
  plot_volcano(so, test='conditionparent', test_type = "wt", which_model = "full",
               sig_level = 0.05, point_alpha = 0.2, sig_color = "red",
               highlight = NULL)
  
  sleuth_table <- sleuth_results(oe, test='conditionparent', show_all = FALSE)
  sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)
  write.table(sleuth_significant, file = paste('sleuth_data/', experiment_name, '.table.tsv', sep=''), 
       sep='\t', row.names = FALSE, quote = FALSE)
}

run_sleuth('experiment')

