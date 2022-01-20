# Long Noncoding RNAs in NSCLC

## Overview

The code is primarily written to be compatible with HPC Slurm Framework. We deploy the following pipeline for RNA-Seq in finding important lncRNA that could be used as therapeutic drug targets

![Flowchart](https://raw.githubusercontent.com/thewayofknowing/lncRNA/main/data/flowchart%20-%201.svg)

# Steps :

## 1) Quality Control 
[<code>make_stats.slurm</code>](1-QC/make_stats.slurm) is used to generate a summary statistic for all the replicates. [<code>qc.slurm</code>](1-QC/qc.slurm) uses _FastQC_ to generate analysis of the replicates. We can use this analysis to judge the quality of our data and if required, use post-processing to clean up

## 2) Mapping
For mapping our reads to the reference Gencode sequence, we will use _HISAT2_ tool. In order, we first need to generate an index for our mapping step. This can be generated using  [<code>make_index.slurm</code>](2-Mapping/make_index.slurm) as follows :
  ```
  hisat2-build -p 4 -f <reference-genome> hg38_gencode
  ```
Using this index, we can run [<code>map_reads.slurm</code>](2-Mapping/map_reads.slurm) to map our sequences and obtain _SAM_ files for each replicate as follows :
  ```
  hisat2 -q -x hg38_gencode --rna-strandness RF -1 <forward-read> -2  <reverse-read> -S <output-sam-file>
  ```
Finally we need to convert these _SAM_ files to a binary format - _BAM_ using [<code>make_bam.slurm</code>](2-Mapping/make_bam.slurm)

## 3) Transcriptome Assembly
This step performs a reference guided assembly of our alignments into potential transcripts. We use the _StringTie_ tool for this step, obtaining a _GTF_ format file for each replicate assembly. Run [<code>run_transcriptome_assembly.slurm</code>](3-Transcriptome/run_transcriptome_assembly.slurm) to obtain individual _GTF_ format files. As a post processing step, we merge all the replicate _GTF_s into one file for the next step as follows :
  ```
  stringtie -o <output-gtf-file> -p 4 --rf -G <reference-gencode-annotation> <bam-file>
  stringtie -o merged.gtf --merge *.gtf
  ```
Since we used reference annotations, some of our transcripts in the output will be known and some will be novel i.e. that do not have a gencode annotation 

## 4) Quantification 
We use _Kallisto_ tool to obtain quantification i.e. expression level estimates of our replicate data. As in Step 2, we first build an index using [<code>build_kallisto_index.slurm</code>](4-Quantify/build_kallisto_index.slurm) as follows :
  ```
  kallisto index --make-unique -i $indices_folder/hg38_kallisto.idx <transcript-gtfs>
  ```
  Next, using the built Kallisto index, we run [<code>quantify.slurm</code>](4-Quantify/quantify.slurm) to quantify the expression levels of our replicates to obtain tables containing TPM (Transcript per million) values. Key code is as follows :
  ```
  kallisto quant -t 4 -b 10 --rf-stranded -i $indices_folder/hg38_kallisto.idx -o $output_dir <forward-read-filename> <reverse-read-filename>
  ```
## 5) Differential Expression 
_Sleuth_ is a popular tool for Differential Gene Expression analysis, and it has seemless integration with _Kallisto_ outputs. _Sleuth_ requires an experiment design, which we constructed in the [<code>experiment.txt</code>](5-DE/experiment.txt) file to list our replicates with the subclone conditions - holo / meta / paraclone as well as the parent - control. We can run [<code>sleuth.R</code>](5-DE/sleuth.R) using the above mentioned experiment design and obtain genes / transcripts that are expressed differently in a significant manner. 

## 6) Integrative Analysis 
 
 #### 1) 5' and 3' end annotation 
  Using _FANTOM CAGE Clusters_, we use _bedtools_ to find the transcripts which have a correct end annotation. For this, we first need to convert    our _GTF_ format file to a _BED_ file as follows : 
  ```
  convert2bed --input=gtf --output=bed < merged.gtf > merged.bed
  ```
   This BED file will be used as input for [<code>tss_annotation_analysis.slurm</code>](6-Analysis/tss_annotation_analysis.slurm) and <code>poly_a_annotation_analysis.slurm</code> which will find matches between our reference guided transcriptome assembly from Step 3. and published _FANTOM_ Transcription Start Site (TSS) / Poly-A Tail Annotation
  ```
  bedtools window -a <transcriptome-bed-file> -b <phantom-cage-tss-bed> -w 100
  bedtools window -a <transcriptome-bed-file> -b <phantom-cage-poly-a-bed> -w 100
  ```
 
 #### 2) Coding Potential 
 We use _CPAT_ tool to determine the coding potential of our novel transcripts and using the filter non-coding sequences using the cutoff 0.364 as published by [CPAT Documentation](https://cpat.readthedocs.io/en/latest/#how-to-choose-cutoff). This step runs the file [<code>run_cpat.sh</code>](6-Analysis/run_cpat.sh), implementing as follows :
 ```
 python3 cpat/bin/cpat.py -x ./Human_Hexamer.tsv --antisense -d ./Human_logitModel.RData --top-orf=5 -g <transcript-file> -o output
 ```
 Precomputed Hexamer table - <code>Human_Hexamer.tsv</code> & Model file - <code>Human_logitModel.RData</code> can be obtained from [CPAT Sourceforge](https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/) page
 
 #### 3) Intergenic transcripts
 We prioritize the transcripts that are inter-genic as they have a higher likelihood to be regulators of the respective gene expressions.
 
### Finally, using all the filters from Step 6. we propose a ranked list of gene candidates that can be tested for therapeutic value in treating NSCLC
