#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="KallistoQuant"
#SBATCH --nodes=2
#SBATCH --cpus-per-task=2
#SBATCH --time=24:00:00
#SBATCH --mem=25G
#SBATCH --output=output_quantify_%j.o
#SBATCH --array=0-11%2

data=/data/users/kkohli/rnaseq/lncRNA/data
reference_annotation_file=$data/reference/GRCh38.primary_assembly.genome.fa
stringtie_output_folder=$data/gtf
indices_folder=$data/indices

module add UHTS/Analysis/kallisto/0.46.0;

sam_file_names=("1_1_L3" "1_2_L3" "1_5_L3" "2_2_L3" "2_3_L3" "2_4_L3" "3_2_L3" "3_4_L3" "3_7_L3" \
				"P1_L3" "P2_L3" "P3_L3") 
				
output_dir_suffix=("1_1" "1_2" "1_5" "2_2" "2_3" "2_4" "3_2" "3_4" "3_7" "P1" "P2" "P3")   

read_filename=${forward_reads[$SLURM_ARRAY_TASK_ID]}_transcript.fa
output_dir="/data/users/kkohli/rnaseq/lncRNA/data/kallisto/${output_dir_suffix[$SLURM_ARRAY_TASK_ID]}"

kallisto quant -t 4 -b 10 --rf-stranded -i $indices_folder/hg38_kallisto.idx -o $output_dir $data/gtf/$read_filename
																			

    
    