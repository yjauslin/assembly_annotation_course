#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_trinity_%j.o
#SBATCH --error=/data/users/yjauslin/error_trinity_%j.e
#SBATCH --partition=pibu_el8

#saving reads and output directory as variables
READS_DIR=/data/users/${USER}/assembly_annotation_course/fastp

OUT_DIR=/data/users/${USER}/assembly_annotation_course/trinity_transcriptome_assembly

#load trinity module
module load Trinity/2.15.1-foss-2021a

#run trinity for paired-end reads in fastq files
Trinity --seqType fq --left $READS_DIR/ERR754081_1_cleaned.fastq.gz --right $READS_DIR/ERR754081_2_cleaned.fastq.gz --CPU 16 --max_memory 64G 