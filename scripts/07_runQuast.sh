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

WORKING_DIR=/data/users/${USER}/assembly_annotation_course

FLYE=/data/users/${USER}/assembly_annotation_course/flye_assembly/assembly.fasta

HIFIASM=/data/users/${USER}/assembly_annotation_course/hifiasm_assembly/ERR11437318.bp.p_ctg.fa

LJA=/data/users/${USER}/assembly_annotation_course/LJA_assembly/assembly.fasta

OUT_DIR=/data/users/${USER}/assembly_annotation_course/quast

CONTAINER=/containers/apptainer/quast_5.2.0.sif

REF_DIR=/data/courses/assembly-annotation-course/references

REF="${REF_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GFF="${REF_DIR}/Arabidopsis_thaliana.TAIR10.57.gff3"

mkdir $OUT_DIR

cp -r $REF $WORKING_DIR
cp -r $GFF $WORKING_DIR

apptainer exec --bind $WORKING_DIR $CONTAINER quast.py \
 $FLYE $HIFIASM $LJA --eukaryote --large --threads ${SLURM_CPUS_PER_TASK} --labels Flye,Hifiasm,LJA \
 --no-sv \
 -r Arabidopsis_thaliana.TAIR10.dna.toplevel.fa --features Arabidopsis_thaliana.TAIR10.57.gff3 \
 -o $OUT_DIR/quast_output_with_r 

apptainer exec --bind /data/users/${USER}/assembly_annotation_course $CONTAINER quast.py \
 $FLYE $HIFIASM $LJA --eukaryote --large --threads ${SLURM_CPUS_PER_TASK} --labels Flye,Hifiasm,LJA \
 --no-sv \
 --features Arabidopsis_thaliana.TAIR10.57.gff3 \
 --est-ref-size 135000000 \
 -o $OUT_DIR/quast_output_without_r 


