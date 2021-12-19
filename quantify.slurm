#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="KallistoQuant"
#SBATCH --nodes=2
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=15G
#SBATCH --output=slurm_output/output_quantify_%j.o
#SBATCH --array=0-11%2


reference_folder=/data/users/kkohli/rnaseq/lncRNA/reference
reference_annotation_file=$reference_folder/GCF_000001405.26_GRCh38_genomic.gff
stringtie_output_folder=/data/users/kkohli/rnaseq/lncRNA/gtf

module add UHTS/Analysis/kallisto/0.46.0;

forward_reads=("1_1_L3_R1_001_ij43KLkHk1vK.fastq.gz" "1_2_L3_R1_001_DnNWKUYhfc9S.fastq.gz" "1_5_L3_R1_001_iXvvRzwmFxF3.fastq.gz" "2_2_L3_R1_001_77KSDZXkzpN2.fastq.gz" \
				"2_3_L3_R1_001_DZmuiRvA53zD.fastq.gz" "2_4_L3_R1_001_ezH0ldTDxUdi.fastq.gz" "3_2_L3_R1_001_DID218YBevN6.fastq.gz" "3_4_L3_R1_001_QDBZnz0vm8Gd.fastq.gz" \
				"3_7_L3_R1_001_Tjox96UQtyIc.fastq.gz" "P1_L3_R1_001_9L0tZ86sF4p8.fastq.gz" "P2_L3_R1_001_R82RphLQ2938.fastq.gz" "P3_L3_R1_001_fjv6hlbFgCST.fastq.gz")

reverse_reads=("1_1_L3_R2_001_qyjToP2TB6N7.fastq.gz" "1_2_L3_R2_001_SNLaVsTQ6pwl.fastq.gz" "1_5_L3_R2_001_iXCMrktKyEh0.fastq.gz" "2_2_L3_R2_001_2oenLbeyyPvS.fastq.gz" \
				"2_3_L3_R2_001_bW28atsMceL2.fastq.gz" "2_4_L3_R2_001_5qJL43xGflsJ.fastq.gz" "3_2_L3_R2_001_UPhWv8AgN1X1.fastq.gz" "3_4_L3_R2_001_ng3ASMYgDCPQ.fastq.gz" \
				"3_7_L3_R2_001_f60CeSASEcgH.fastq.gz" "P1_L3_R2_001_yd9NfV9WdvvL.fastq.gz" "P2_L3_R2_001_06FRMIIGwpH6.fastq.gz" "P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz")
				
output_dir_suffix=("1_1" "1_2" "1_5" "2_2" "2_3" "2_4" "3_2" "3_4" "3_7" "P1" "P2" "P3")   

forward_read_filename=${forward_reads[$SLURM_ARRAY_TASK_ID]}
reverse_read_filename=${reverse_reads[$SLURM_ARRAY_TASK_ID]}
output_dir="/data/users/kkohli/rnaseq/lncRNA/archive/kallisto/${output_dir_suffix[$SLURM_ARRAY_TASK_ID]}"

#BUILD KALLISTO INDEX
# kallisto index --make-unique -i $reference_folder/hg38_kallisto.idx $stringtie_output_folder/*_transcript.fa

kallisto quant -t 4 -b 10 -i $reference_folder/hg38_kallisto.idx -o $output_dir fastq/$forward_read_filename fastq/$reverse_read_filename 
																			

    
    