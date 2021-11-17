#!/bin/bash

#SBATCH --mail-type=fail
#SBATCH --job-name="HG34Index"
#SBATCH --nodes=4
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=40G

module add UHTS/Aligner/hisat/2.2.1

hisat2-build ./reference/GCF_000001405.26_GRCh38_genomic.fna.gz hg34_index
