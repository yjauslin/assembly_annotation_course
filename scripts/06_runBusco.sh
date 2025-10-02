#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=60G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=busco
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_busco_%j.o
#SBATCH --error=/data/users/yjauslin/error_busco_%j.e
#SBATCH --partition=pibu_el8
#SBATCH --array=0-3

#save respective assembly paths as variables
FLYE=/data/users/${USER}/assembly_annotation_course/flye_assembly/assembly.fasta

HIFIASM=/data/users/${USER}/assembly_annotation_course/hifiasm_assembly/ERR11437318.bp.p_ctg.fa

LJA=/data/users/${USER}/assembly_annotation_course/LJA_assembly/assembly.fasta

TRINITY=/data/users/${USER}/assembly_annotation_course/trinity_out_dir.Trinity.fasta

#save output directory as variable
OUT_DIR=/data/users/${USER}/assembly_annotation_course/busco

#create array with assembly paths
input=($FLYE $HIFIASM $LJA $TRINITY)

#create array for nice output labels
assembly=(flye hifiasm lja trinity)

#create array to set the mode for busco
modes=(genome genome genome transcriptome)

#create output directory
mkdir $OUT_DIR

#load busco module
module load BUSCO/5.4.2-foss-2021a

#running busco using auto-lineage (lineage was checked afterwards and turned out to be correct)
busco -i ${input[$SLURM_ARRAY_TASK_ID]} --auto-lineage --cpu ${SLURM_CPUS_PER_TASK} --mode ${modes[$SLURM_ARRAY_TASK_ID]} --out_path $OUT_DIR -o ${assembly[$SLURM_ARRAY_TASK_ID]}