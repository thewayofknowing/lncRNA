#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="PolyA Annotation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=5G
#SBATCH --output=output_poly.o
#SBATCH --error=error_poly.e

data_folder=/data/users/kkohli/rnaseq/lncRNA/data

hg38_polyA_bed=$data_folder/gtf/polya_annotation.bed
transcriptome_bed=$data_folder/gtf/merged.bed

module add UHTS/Analysis/BEDTools/2.29.2;

bedtools window -u -a $transcriptome_bed -b $hg38_polyA_bed -w 100
