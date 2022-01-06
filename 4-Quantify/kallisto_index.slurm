#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="KallistoQuant"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=25G
#SBATCH --output=slurm_output/output_quantify_%j.o
#SBATCH --array=0-11%4

data=/data/users/kkohli/rnaseq/lncRNA/data
reference_annotation_file=$data/reference/GRCh38.primary_assembly.genome.fa
stringtie_output_folder=$data/gtf

module add UHTS/Analysis/kallisto/0.46.0;

#BUILD KALLISTO INDEX
kallisto index --make-unique -i $reference_folder/hg38_kallisto.idx $stringtie_output_folder/*_transcript.fa
																			

    
    