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

WORK_DIR=/data/users/${USER}/assembly_annotation_course

export MERQURY="/usr/local/share/merqury"

GENOME_SIZE=135000000

apptainer exec --bind $WORK_DIR $CONTAINER \
 sh $MERQURY/08_getBestKmer.sh ${GENOME_SIZE} 0.001
