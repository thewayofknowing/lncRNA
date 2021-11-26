#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="MappingReads"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=50G
#SBATCH --output=slurm_output/output_alignment_%j.o

#SBATCH --array=0-11%6

module add UHTS/Aligner/hisat/2.2.1

sam_files_folder=sam

forward_reads=("1_1_L3_R1_001_ij43KLkHk1vK.fastq" "1_2_L3_R1_001_DnNWKUYhfc9S.fastq" "1_5_L3_R1_001_iXvvRzwmFxF3.fastq" "2_2_L3_R1_001_77KSDZXkzpN2.fastq" \
				"2_3_L3_R1_001_DZmuiRvA53zD.fastq" "2_4_L3_R1_001_ezH0ldTDxUdi.fastq" "3_2_L3_R1_001_DID218YBevN6.fastq" "3_4_L3_R1_001_QDBZnz0vm8Gd.fastq" \
				"3_7_L3_R1_001_Tjox96UQtyIc.fastq" "P1_L3_R1_001_9L0tZ86sF4p8.fastq" "P2_L3_R1_001_R82RphLQ2938.fastq" "P3_L3_R1_001_fjv6hlbFgCST.fastq")

reverse_reads=("1_1_L3_R2_001_qyjToP2TB6N7.fastq" "1_2_L3_R2_001_SNLaVsTQ6pwl.fastq" "1_5_L3_R2_001_iXCMrktKyEh0.fastq" "2_2_L3_R2_001_2oenLbeyyPvS.fastq" \
				"2_3_L3_R2_001_bW28atsMceL2.fastq" "2_4_L3_R2_001_5qJL43xGflsJ.fastq" "3_2_L3_R2_001_UPhWv8AgN1X1.fastq" "3_4_L3_R2_001_ng3ASMYgDCPQ.fastq" \
				"3_7_L3_R2_001_f60CeSASEcgH.fastq" "P1_L3_R2_001_yd9NfV9WdvvL.fastq" "P2_L3_R2_001_06FRMIIGwpH6.fastq" "P3_L3_R2_001_xo7RBLLYYqeu.fastq")

sam_file_names=("1_1_L3.sam" "1_2_L3.sam" "1_5_L3.sam" "2_2_L3.sam" "2_3_L3.sam" "2_4_L3.sam" "3_2_L3.sam" "3_4_L3.sam" "3_7_L3.sam" \
				"P1_L3.sam" "P2_L3.sam" "P3_L3.sam") 

hisat2 -q -x genome_index/hg34_index --rna-strandness RF -1 fastq/${forward_reads[$SLURM_ARRAY_TASK_ID]} -2  fastq/${reverse_reads[$SLURM_ARRAY_TASK_ID]} \
												-S $sam_files_folder/${sam_file_names[$SLURM_ARRAY_TASK_ID]}
					
										
