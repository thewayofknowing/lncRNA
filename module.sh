export PATH=/data/users/lfalquet/SBC07107_21/scripts:/software/bin:/usr/local/bin:$PATH;
export PATH=/data/users/lfalquet/SBC07107_21/scripts/canu-2.2/bin:/data/users/lfalquet/SBC07107_21/scripts/Flye-2.9/bin:$PATH
export LANG=en_US.UTF-8
module use /software/module/
module add UHTS/Quality_control/fastqc/0.11.7
module add UHTS/Analysis/MultiQC/1.8
#module add UHTS/Analysis/fastx_toolkit/0.0.13.2
module add UHTS/Aligner/bwa/0.7.17
module add UHTS/Analysis/samtools/1.10
module add Emboss/EMBOSS/6.6.0
module add UHTS/Analysis/SOAPdenovo2/2.04.241;
module add UHTS/Assembler/abyss/2.0.2;
module add UHTS/Assembler/SPAdes/3.14.0;
module add UHTS/Analysis/vcftools/0.1.15;
module add UHTS/Analysis/HTSeq/0.9.1;
module add UHTS/Analysis/mummer/4.0.0beta1
module add UHTS/Aligner/bowtie2/2.3.4.1
module add Development/java/latest
module add UHTS/Analysis/prokka/1.13
module add UHTS/Analysis/aragorn/1.2.38
module add SequenceAnalysis/MultipleSequenceAlignment/mafft/7.310
module add SequenceAnalysis/MultipleSequenceAlignment/prank/170427
module add SequenceAnalysis/StructurePrediction/mcl/14.137
module add UHTS/Analysis/cd-hit/4.6.8
module add UHTS/Analysis/BEDTools/2.29.2
module add Phylogeny/FastTree/2.1.10
module add UHTS/Analysis/GenomeAnalysisTK/4.1.3.0
module add UHTS/Analysis/picard-tools/2.21.8
module add UHTS/Analysis/trimmomatic/0.36
module add UHTS/Analysis/Roary/3.11.0
module add UHTS/Quality_control/fastp/0.19.5
module add UHTS/Assembler/canu/2.1
module add UHTS/Analysis/minimap2/2.17
module add UHTS/Analysis/busco/3.0.2
module add UHTS/Analysis/SeqKit/0.13.2
#purge_haplotig use conda 
#ipa use conda
#hifiasm install in scripts
#Flye install in scripts
export EMBOSS_FILTER=1

