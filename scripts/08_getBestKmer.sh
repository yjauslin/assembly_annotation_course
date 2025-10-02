#!/usr/bin/env bash

#SBATCH --time=00:10:00
#SBATCH --mem=5G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=kmer
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_kmer_%j.o
#SBATCH --error=/data/users/yjauslin/error_kmer_%j.e
#SBATCH --partition=pibu_el8

#save working- and container directory as variables
WORK_DIR=/data/users/${USER}/assembly_annotation_course

CONTAINER="/containers/apptainer/merqury_1.3.sif"

#add merqury as a path variable
export MERQURY="/usr/local/share/merqury"

#save estimated genome size of the assemblies as variables
GENOME_SIZE=143000000

#find best k size with tolerable collision rate = 0.001
apptainer exec --bind $WORK_DIR $CONTAINER \
 sh ${MERQURY}/best_k.sh ${GENOME_SIZE} 0.001


