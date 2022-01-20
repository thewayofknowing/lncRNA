#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="PolyA Annotation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=5G
#SBATCH --output=output_intergenic.o
#SBATCH --error=error_intergenic.e

data_folder=/data/users/kkohli/rnaseq/lncRNA/data

reference=$data_folder/reference/gencode.v38.annotation.gtf
transcriptome_bed=$data_folder/gtf/merged.bed

module add UHTS/Analysis/BEDTools/2.29.2;

bedtools window -a $transcriptome_bed -b $reference -w 100