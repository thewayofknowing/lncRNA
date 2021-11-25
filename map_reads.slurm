#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="MappingReads"
#SBATCH --nodes=8
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=40G

module add UHTS/Aligner/hisat/2.2.1

#hisat2 -q -x genome_index/hg34_index -1 fastq/1_1_L3_R1_001_ij43KLkHk1vK.fastq -2  fastq/1_1_L3_R2_001_qyjToP2TB6N7.fastq -S 1_1_L3.sam
#hisat2 -q -x genome_index/hg34_index -1	fastq/1_2_L3_R1_001_DnNWKUYhfc9S.fastq -2 fastq/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq -S 1_2_L3.sam	
#hisat2 -q -x genome_index/hg34_index -1	fastq/1_5_L3_R1_001_iXvvRzwmFxF3.fastq -2 fastq/1_5_L3_R2_001_iXCMrktKyEh0.fastq -S 1_5_L3.sam
#hisat2 -q -x genome_index/hg34_index -1	fastq/2_2_L3_R1_001_77KSDZXkzpN2.fastq -2 fastq/2_2_L3_R2_001_2oenLbeyyPvS.fastq -S 2_2_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/2_3_L3_R1_001_DZmuiRvA53zD.fastq -2 fastq/2_3_L3_R2_001_bW28atsMceL2.fastq -S 2_3_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/2_4_L3_R1_001_ezH0ldTDxUdi.fastq -2 fastq/2_4_L3_R2_001_5qJL43xGflsJ.fastq -S 2_4_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/3_2_L3_R1_001_DID218YBevN6.fastq -2 fastq/3_2_L3_R2_001_UPhWv8AgN1X1.fastq -S 3_2_L3.sam
hisat2 -q -x genome_index/hg34_index -1 fastq/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq -2 fastq/3_4_L3_R2_001_ng3ASMYgDCPQ.fastq -S 3_4_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/3_7_L3_R1_001_Tjox96UQtyIc.fastq -2 fastq/3_7_L3_R2_001_f60CeSASEcgH.fastq -S 3_7_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/P1_L3_R1_001_9L0tZ86sF4p8.fastq -2 fastq/P1_L3_R2_001_yd9NfV9WdvvL.fastq -S P1_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/P2_L3_R1_001_R82RphLQ2938.fastq -2 fastq/P2_L3_R2_001_06FRMIIGwpH6.fastq -S P2_L3.sam
#hisat2 -q -x genome_index/hg34_index -1 fastq/P3_L3_R1_001_fjv6hlbFgCST.fastq -2 fastq/P3_L3_R2_001_xo7RBLLYYqeu.fastq -S P3_L3.sam
					
										
