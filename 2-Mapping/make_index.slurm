#!/bin/bash

#SBATCH --mail-type=fail,success
#SBATCH --job-name="MappingReads"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=25G

reference=/data/users/kkohli/rnaseq/lncRNA/data/reference/GRCh38.primary_assembly.genome.fa

module add UHTS/Aligner/hisat/2.2.1

hisat2-build -p 4 -f $reference hg38_gencode
