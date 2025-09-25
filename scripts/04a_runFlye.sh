#!/usr/bin/env bash

#SBATCH --time=2-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_flye_%j.o
#SBATCH --error=/data/users/yjauslin/error_flye_%j.e
#SBATCH --partition=pibu_el8

#saving reads, container and output directory as variables
READS_DIR=/data/users/${USER}/assembly_annotation_course/Hiroshima

CONTAINER_DIR=/containers/apptainer/flye_2.9.5.sif

OUT_DIR=/data/users/${USER}/assembly_annotation_course/flye_assembly

#creating output directory
mkdir ${OUT_DIR}

#creating flye-assembly using pacbio-hifi reads
apptainer exec --bind $READS_DIR $CONTAINER_DIR flye --pacbio-hifi $READS_DIR/*.fastq.gz --out-dir $OUT_DIR --threads 16