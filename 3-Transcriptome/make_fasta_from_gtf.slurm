#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="Transcriptome Fasta"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=10G
#SBATCH --output=slurm_output/output_transcriptome_%j.o
#SBATCH --array=0-11%6

data=/data/users/kkohli/rnaseq/lncRNA/data
reference_file=$data/reference/GRCh38.primary_assembly.genome.fa
stringtie_output_folder=$data/gtf

module add UHTS/Assembler/cufflinks/2.2.1;

sam_file_names=("1_1_L3" "1_2_L3" "1_5_L3" "2_2_L3" "2_3_L3" "2_4_L3" "3_2_L3" "3_4_L3" "3_7_L3" \
				"P1_L3" "P2_L3" "P3_L3") 

filename=${sam_file_names[$SLURM_ARRAY_TASK_ID]}

gffread -w $stringtie_output_folder/$filename\_transcript.fa -g $reference_file $stringtie_output_folder/$filename\.gtf