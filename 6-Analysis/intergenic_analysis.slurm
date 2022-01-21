#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="PolyA Annotation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=5G
#SBATCH --output=output_intergenic_1.o
#SBATCH --error=error_intergenic.e

data_folder=/data/users/kkohli/rnaseq/lncRNA/data

reference=$data_folder/reference/protein.coding.gencode.gtf
transcriptome_bed=$data_folder/gtf/merged.bed

module add UHTS/Analysis/BEDTools/2.29.2;

bedtools window -v -a $transcriptome_bed -b $reference 
