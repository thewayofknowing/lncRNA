#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="MakeBAM"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=25G
#SBATCH --output=output_bam_%j.o

#SBATCH --array=0-11%6

data=/data/users/kkohli/rnaseq/lncRNA/data
bam_index_file=$data/reference/GRCh38.primary_assembly.genome.fa
sam_files_folder=$data/sam
bam_files_folder=$data/bam

module add UHTS/Analysis/samtools/1.10

sam_file_names=("1_1_L3" "1_2_L3" "1_5_L3" "2_2_L3" "2_3_L3" "2_4_L3" "3_2_L3" "3_4_L3" "3_7_L3" \
				"P1_L3" "P2_L3" "P3_L3") 

filename=${sam_file_names[$SLURM_ARRAY_TASK_ID]}

#CONVERT SAM TO BAM
samtools view -@ 4 -bt $bam_index_file -o  $bam_files_folder/$filename\_unsorted.bam $sam_files_folder/$filename\.sam  

#SORT BAM					
samtools sort -@ 4 -o $bam_files_folder/$filename\.bam $bam_files_folder/$filename\_unsorted.bam
rm $bam_files_folder/$filename\_unsorted.bam

#INDEX BAM
samtools index $bam_files_folder/$filename\.bam
										
