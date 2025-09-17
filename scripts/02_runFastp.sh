#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_fastp_%j.o
#SBATCH --error=/data/users/yjauslin/error_fastp_%j.e
#SBATCH --partition=pibu_el8

#save read and container directories as variables
HIROSHIMA=/data/users/${USER}/assembly_annotation_course/Hiroshima
RNAseq_Sha=/data/users/${USER}/assembly_annotation_course/RNAseq_Sha
CONTAINER=/containers/apptainer/fastp_0.23.2--h5f740d0_3.sif

#save out directory as variable
OUT_DIR=/data/users/${USER}/assembly_annotation_course/fastp

#move to project directory and create output directory
cd /data/users/${USER}/assembly_annotation_course
mkdir ${OUT_DIR}

#cleaning PacBio file using fastp (no quality filtering)
apptainer exec --bind ${HIROSHIMA} ${CONTAINER} fastp -Q -i $HIROSHIMA/ERR11437318.fastq.gz  -o ${OUT_DIR}/ERR11437318_cleaned.fastq.gz

#cleaning Illumina file using fastp
apptainer exec --bind ${RNAseq_Sha} ${CONTAINER} fastp -i $RNAseq_Sha/ERR754081_1.fastq.gz -I $RNAseq_Sha/ERR754081_2.fastq.gz \
 -o ${OUT_DIR}/ERR754081_1_cleaned.fastq.gz -O ${OUT_DIR}/ERR754081_2_cleaned.fastq.gz
