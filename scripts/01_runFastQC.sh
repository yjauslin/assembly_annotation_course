#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_fastqc_%j.o
#SBATCH --error=/data/users/yjauslin/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

#save read and container directories as variables
HIROSHIMA=/data/users/${USER}/assembly_annotation_course/Hiroshima
RNAseq_Sha=/data/users/${USER}/assembly_annotation_course/RNAseq_Sha
CONTAINER=/containers/apptainer/fastqc-0.12.1.sif

#go to project directory and create output directory for fastqc
cd /data/users/${USER}/assembly_annotation_course
mkdir fastqc

#open container and execute fastqc for all the read files in HIROSHIMA, add files to output directory
apptainer exec --bind ${HIROSHIMA} ${CONTAINER} \
fastqc \
--outdir /data/users/${USER}/assembly_annotation_course/fastqc \
"$HIROSHIMA"/*.fastq.gz

#open container and execute fastqc for all the read files in RNAseq_Sha, add files to output directory
apptainer exec --bind ${RNAseq_Sha} ${CONTAINER} \
fastqc \
--outdir /data/users/${USER}/assembly_annotation_course/fastqc \
"$RNAseq_Sha"/*.fastq.gz

