#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=5G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=meryl
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_meryl_%j.o
#SBATCH --error=/data/users/yjauslin/error_meryl_%j.e
#SBATCH --partition=pibu_el8

#save working-, container-, reads- and output directories as variables
WORK_DIR=/data/users/${USER}/assembly_annotation_course

CONTAINER="/containers/apptainer/merqury_1.3.sif"

READS="${WORK_DIR}/Hiroshima/ERR11437318.fastq.gz"

OUT_DIR=${WORK_DIR}/mercury

#create output directory
mkdir $OUT_DIR

#create meryldb for the best kmer count obtained from the results of 08_getBestKmer.sh
apptainer exec --bind /data ${CONTAINER} meryl k=19 count \
  ${READS} output ${OUT_DIR}/reads.meryl     