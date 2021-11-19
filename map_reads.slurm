#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="MappingReads"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=40G

module add UHTS/Aligner/hisat/2.2.1

hisat2 -q -x genome_index/hg34_index \
				-1 	fastq/1_1_L3_R1_001_ij43KLkHk1vK.fastq, \
					fastq/1_2_L3_R1_001_DnNWKUYhfc9S.fastq, \		
					fastq/1_5_L3_R1_001_iXvvRzwmFxF3.fastq, \
					fastq/2_2_L3_R1_001_77KSDZXkzpN2.fastq, \
					fastq/2_3_L3_R1_001_DZmuiRvA53zD.fastq, \
					fastq/2_4_L3_R1_001_ezH0ldTDxUdi.fastq, \
					fastq/3_2_L3_R1_001_DID218YBevN6.fastq, \
					fastq/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq, \
					fastq/3_7_L3_R1_001_Tjox96UQtyIc.fastq, \
					fastq/P1_L3_R1_001_9L0tZ86sF4p8.fastq, \
					fastq/P2_L3_R1_001_R82RphLQ2938.fastq, \
					fastq/P3_L3_R1_001_fjv6hlbFgCST.fastq \
				-2  fastq/1_1_L3_R2_001_qyjToP2TB6N7.fastq, \
					fastq/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq, \
					fastq/1_5_L3_R2_001_iXCMrktKyEh0.fastq, \
					fastq/2_2_L3_R2_001_2oenLbeyyPvS.fastq, \
					fastq/2_3_L3_R2_001_bW28atsMceL2.fastq, \
					fastq/2_4_L3_R2_001_5qJL43xGflsJ.fastq, \
					fastq/3_2_L3_R2_001_UPhWv8AgN1X1.fastq, \
					fastq/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq, \
					fastq/3_7_L3_R2_001_f60CeSASEcgH.fastq, \
					fastq/P1_L3_R2_001_yd9NfV9WdvvL.fastq, \
					fastq/P2_L3_R2_001_06FRMIIGwpH6.fastq, \
					fastq/P3_L3_R2_001_xo7RBLLYYqeu.fastq \
				-S mapping.sam
					
										
