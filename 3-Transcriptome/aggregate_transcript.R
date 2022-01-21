setwd("~/UniBe/HS2021/RNA Seq/lncRNA")
library('dplyr')

df <- read.table('3-Transcriptome/pretty_merged_gtf.tsv', header=TRUE)

df_exons <- df[df$type == 'exon',]
df_exons$exon_number <- as.numeric(df_exons$exon_number)

df_transcript_exon_count <- df_exons %>% group_by(transcript_id) %>% summarise(n_exons = max(exon_number))
df_gene_exon_count <- df_exons %>% group_by(gene_id) %>% summarise(n_exons = max(exon_number))


write.table(df_transcript_exon_count, 'transcript-exon.tsv', row.names = FALSE, sep='\t', quote = FALSE)
write.table(df_gene_exon_count, 'gene-exon.tsv', row.names = FALSE, sep='\t', quote = FALSE)
