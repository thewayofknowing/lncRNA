#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="TSS Annotation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=5G
#SBATCH --output=output_tss.o
#SBATCH --error=error_tss.e

data_folder=/data/users/kkohli/rnaseq/lncRNA/data

hg38_tss_bed=$data_folder/gtf/hg38.nobarcode.ctss.bed
transcriptome_bed=$data_folder/gtf/merged.bed

module add UHTS/Analysis/BEDTools/2.29.2;

bedtools window -a $hg38_tss_bed -b $transcriptome_bed -w 100