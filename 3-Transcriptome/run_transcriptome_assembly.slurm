#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="TranscriptomeAssembly"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=25G
#SBATCH --output=output_transcriptome_%j.o
#SBATCH --array=0-11%6

data=/data/users/kkohli/rnaseq/lncRNA/data
reference_annotation_file=$data/reference/gencode.v38.annotation.gtf
bam_files_folder=$data/bam
stringtie_output_folder=$data/gtf

stringtie=/data/users/kkohli/rnaseq/stringtie2.3/stringtie
#module add UHTS/Aligner/stringtie/1.3.3b;

sam_file_names=("1_1_L3" "1_2_L3" "1_5_L3" "2_2_L3" "2_3_L3" "2_4_L3" "3_2_L3" "3_4_L3" "3_7_L3" \
				"P1_L3" "P2_L3" "P3_L3") 

filename=${sam_file_names[$SLURM_ARRAY_TASK_ID]}

#RUN TRANSCRIPTOME ASSEMBLY
$stringtie -o $stringtie_output_folder/$filename\.gtf -p 4 --rf -G $reference_annotation_file $bam_files_folder/$filename\.bam

#JUST RUN ON COMMAND LINE TO AVOID RACE CONDITION WITH SLURM ARRAYS										
#stringtie -o merged.gtf --merge *.gtf
# module add UHTS/Analysis/bedops/2.4.40;
# convert2bed --input=gtf --output=bed < merged.gtf > merged.bed

