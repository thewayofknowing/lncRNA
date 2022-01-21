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

forward_reads=("1_1_L3_R1_001_ij43KLkHk1vK.fastq" "1_2_L3_R1_001_DnNWKUYhfc9S.fastq" "1_5_L3_R1_001_iXvvRzwmFxF3.fastq" "2_2_L3_R1_001_77KSDZXkzpN2.fastq" \
				"2_3_L3_R1_001_DZmuiRvA53zD.fastq" "2_4_L3_R1_001_ezH0ldTDxUdi.fastq" "3_2_L3_R1_001_DID218YBevN6.fastq" "3_4_L3_R1_001_QDBZnz0vm8Gd.fastq" \
				"3_7_L3_R1_001_Tjox96UQtyIc.fastq" "P1_L3_R1_001_9L0tZ86sF4p8.fastq" "P2_L3_R1_001_R82RphLQ2938.fastq" "P3_L3_R1_001_fjv6hlbFgCST.fastq")

reverse_reads=("1_1_L3_R2_001_qyjToP2TB6N7.fastq" "1_2_L3_R2_001_SNLaVsTQ6pwl.fastq" "1_5_L3_R2_001_iXCMrktKyEh0.fastq" "2_2_L3_R2_001_2oenLbeyyPvS.fastq" \
				"2_3_L3_R2_001_bW28atsMceL2.fastq" "2_4_L3_R2_001_5qJL43xGflsJ.fastq" "3_2_L3_R2_001_UPhWv8AgN1X1.fastq" "3_4_L3_R2_001_ng3ASMYgDCPQ.fastq" \
				"3_7_L3_R2_001_f60CeSASEcgH.fastq" "P1_L3_R2_001_yd9NfV9WdvvL.fastq" "P2_L3_R2_001_06FRMIIGwpH6.fastq" "P3_L3_R2_001_xo7RBLLYYqeu.fastq")
				
output_dir_suffix=("1_1" "1_2" "1_5" "2_2" "2_3" "2_4" "3_2" "3_4" "3_7" "P1" "P2" "P3")   

forward_read_filename=${forward_reads[$SLURM_ARRAY_TASK_ID]}
reverse_read_filename=${reverse_reads[$SLURM_ARRAY_TASK_ID]}
output_dir="/data/users/kkohli/rnaseq/lncRNA/data/kallisto/${output_dir_suffix[$SLURM_ARRAY_TASK_ID]}"

kallisto quant -t 4 -b 10 --rf-stranded -i $indices_folder/hg38_kallisto.idx -o $output_dir $data/fastq/$forward_read_filename $data/fastq/$reverse_read_filename 
																			

    
    