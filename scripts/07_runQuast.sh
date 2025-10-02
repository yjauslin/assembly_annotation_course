#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=60G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=quast
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_quast_%j.o
#SBATCH --error=/data/users/yjauslin/error_quast_%j.e
#SBATCH --partition=pibu_el8

#save working directory as variable
WORKING_DIR=/data/users/${USER}/assembly_annotation_course

#save assemblies as variable
FLYE=/data/users/${USER}/assembly_annotation_course/flye_assembly/assembly.fasta

HIFIASM=/data/users/${USER}/assembly_annotation_course/hifiasm_assembly/ERR11437318.bp.p_ctg.fa

LJA=/data/users/${USER}/assembly_annotation_course/LJA_assembly/assembly.fasta

#save out- and container directory as variable
OUT_DIR=/data/users/${USER}/assembly_annotation_course/quast

CONTAINER=/containers/apptainer/quast_5.2.0.sif

#save reference directory, reference and GFF-feature file as variables
REF_DIR=/data/courses/assembly-annotation-course/references

REF="${REF_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GFF="${REF_DIR}/Arabidopsis_thaliana.TAIR10.57.gff3"

#create output directory
mkdir $OUT_DIR

#copy reference- and gff-file into working directory
cp -r $REF $WORKING_DIR
cp -r $GFF $WORKING_DIR

#run quast with reference
apptainer exec --bind $WORKING_DIR $CONTAINER quast.py \
 $FLYE $HIFIASM $LJA --eukaryote --large --threads ${SLURM_CPUS_PER_TASK} --labels Flye,Hifiasm,LJA \
 --no-sv \
 -r Arabidopsis_thaliana.TAIR10.dna.toplevel.fa --features Arabidopsis_thaliana.TAIR10.57.gff3 \
 -o $OUT_DIR/quast_output_with_r 

#run quast without reference
apptainer exec --bind /data/users/${USER}/assembly_annotation_course $CONTAINER quast.py \
 $FLYE $HIFIASM $LJA --eukaryote --large --threads ${SLURM_CPUS_PER_TASK} --labels Flye,Hifiasm,LJA \
 --no-sv \
 --features Arabidopsis_thaliana.TAIR10.57.gff3 \
 --est-ref-size 143000000 \
 -o $OUT_DIR/quast_output_without_r 


