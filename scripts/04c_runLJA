#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=LJA
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_LJA_%j.o
#SBATCH --error=/data/users/yjauslin/error_LJA_%j.e
#SBATCH --partition=pibu_el8

#saving reads, container and output directory as variables
READS_DIR=/data/users/${USER}/assembly_annotation_course/Hiroshima

CONTAINER_DIR=/containers/apptainer/lja-0.2.sif

OUT_DIR=/data/users/${USER}/assembly_annotation_course/LJA_assembly

#creating output directory
mkdir ${OUT_DIR}

#run LJA
apptainer exec --bind $READS_DIR $CONTAINER_DIR lja -o $OUT_DIR --reads $READS_DIR/*fastq.gz
