#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="KallistoIndex"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=15G
#SBATCH --output=output_quantify.o

data=/data/users/kkohli/rnaseq/lncRNA/data
reference_annotation_file=$data/reference/GRCh38.primary_assembly.genome.fa
indices_folder=$data/indices
stringtie_output_folder=$data/gtf

module add UHTS/Analysis/kallisto/0.46.0;

#BUILD KALLISTO INDEX
kallisto index --make-unique -i $indices_folder/hg38_kallisto.idx $stringtie_output_folder/*_transcript.fa
																			

    
    