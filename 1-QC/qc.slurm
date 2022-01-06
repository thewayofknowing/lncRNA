#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="QC"
#SBATCH --nodes=4
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=25G
#SBATCH --output=slurm_output/output_qc.o


module add UHTS/Quality_control/fastqc/0.11.9;
module add UHTS/Analysis/MultiQC/1.8;

fastq_folder=/data/users/kkohli/rnaseq/lncRNA/fastq
fastqc_output_folder=/data/users/kkohli/rnaseq/lncRNA/fastqc_output

#FASTQC OF ALL FASTQ FILES
fastqc -t 4 $fastq_folder/*.fastq.gz -o $fastqc_output_folder
										
#COMBINE OUTPUT USING MultiQC
multiqc $fastqc_output_folder