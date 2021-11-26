#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="ProducingStats"
#SBATCH --nodes=2
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=40G

module add UHTS/Analysis/SeqKit/0.13.2

seqkit stats fastq/*.fastq > archive/fastq_stats.txt


										
