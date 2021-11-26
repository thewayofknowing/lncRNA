#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="TranscriptomeAssembly"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=50G
#SBATCH --output=slurm_output/transcriptome_assembly_%j.o

#SBATCH --array=0-11%7

reference_annotation_file=reference/gencode.v38.annotation.gtf
bam_files_folder=bam
stringtie_output_folder=gtf

module add UHTS/Aligner/stringtie/1.3.3b;


sam_file_names=("1_1_L3" "1_2_L3" "1_5_L3" "2_2_L3" "2_3_L3" "2_4_L3" "3_2_L3" "3_4_L3" "3_7_L3" \
				"P1_L3" "P2_L3" "P3_L3") 

filename=${sam_file_names[$SLURM_ARRAY_TASK_ID]}

#RUN TRANSCRIPTOME ASSEMBLY
stringtie -o $stringtie_output_folder/$filename\.gtf -p 4 --rf -G $reference_annotation_file $bam_files_folder/$filename\.bam
										
