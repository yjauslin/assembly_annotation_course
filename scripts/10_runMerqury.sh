#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=merqury
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_merqury_%j.o
#SBATCH --error=/data/users/yjauslin/error_merqury_%j.e
#SBATCH --partition=pibu_el8
#SBATCH --array=0-2

#save working directory as variable
WORK_DIR=/data/users/${USER}/assembly_annotation_course

#save output directory as variable
OUT_DIR=$WORK_DIR/mercury

#save assembly directories as variables
FLYE_DIR=$WORK_DIR/flye_assembly

HIFIASM_DIR=$WORK_DIR/hifiasm_assembly

LJA_DIR=$WORK_DIR/LJA_assembly

#save container directory as variable
CONTAINER=containers/apptainer/merqury_1.3.sif

#save assemblies as variables
FLYE=${FLYE_DIR}/assembly.fasta

HIFIASM=${HIFIASM_DIR}/ERR11437318.bp.p_ctg.fa

LJA=${LJA_DIR}/assembly.fasta

#create arrays for input directories and assemblies
input_dir=($FLYE_DIR $HIFIASM_DIR $LJA_DIR)
assemblies=($FLYE $HIFIASM $LJA)

#create label-array for nice output names later on
labels=(flye hifiasm lja)

export MERQURY="/usr/local/share/merqury"

#move to respective input directory
cd ${input_dir[$SLURM_ARRAY_TASK_ID]}

#evaluate each assembly with mercury
apptainer exec --bind ${input_dir[$SLURM_ARRAY_TASK_ID]} $CONTAINER ${MERQURY}/merqury.sh \
 $OUT_DIR/reads.meryl ${assemblies[$SLURM_ARRAY_TASK_ID]} ${labels[$SLURM_ARRAY_TASK_ID]} \
 > flye_merqury.log 2>&1