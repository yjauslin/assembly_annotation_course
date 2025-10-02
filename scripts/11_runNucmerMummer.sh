#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=mummer
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_mummer_%j.o
#SBATCH --error=/data/users/yjauslin/error_mummer_%j.e
#SBATCH --partition=pibu_el8

#save working directory as variable
WORK_DIR=/data/users/${USER}/assembly_annotation_course

#save output directory as variable
OUT_DIR=$WORK_DIR/mummer

#save assembly directories as variables
FLYE_DIR=$WORK_DIR/flye_assembly

HIFIASM_DIR=$WORK_DIR/hifiasm_assembly

LJA_DIR=$WORK_DIR/LJA_assembly

#save container directory as variable
CONTAINER=/containers/apptainer/mummer4_gnuplot.sif

#save assemblies as variables
FLYE=${FLYE_DIR}/assembly.fasta

HIFIASM=${HIFIASM_DIR}/ERR11437318.bp.p_ctg.fa

LJA=${LJA_DIR}/assembly.fasta

#save reference file as variable
REFERENCE_DIR="/data/courses/assembly-annotation-course/references"
REF="${REFERENCE_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

mkdir $OUT_DIR

compare_assembly(){
    #save query, reference and prefix as variables
    QUERY=$1
    REFERENCE=$2
    PREFIX=$3
    
    #run nucmer
    apptainer exec --bind $WORK_DIR $CONTAINER nucmer \
    --prefix $PREFIX --breaklen 1000 --mincluster 1000 \
      $REFERENCE $QUERY 
    
    #remove secondary alignments by mapping each query contig only once to the reference
    apptainer exec --bind $WORK_DIR $CONTAINER delta-filter -1 ${PREFIX}.delta > ${PREFIX}.filtered.delta

    #create dotplot
    apptainer exec --bind $WORK_DIR $CONTAINER mummerplot \
      -R $REFERENCE -Q $QUERY \
      --prefix=${PREFIX} --filter --fat --layout --large -t png \
      ${PREFIX}.filtered.delta
    
    #display coordinates and other possibly useful information about the alignments
    apptainer exec --bind $WORK_DIR $CONTAINER show-coords \
      -rcl ${PREFIX}.filtered.delta > ${PREFIX}.coords.txt


}

#Comparison: Assemblies vs Reference
compare_assembly $REF $FLYE flye_vs_ref
compare_assembly $REF $HIFIASM hifiasm_vs_ref
compare_assembly $REF $LJA lja_vs_ref

#Comparison: Pairwise Assemblies
compare_assembly $FLYE $HIFIASM flye_vs_hifiasm
compare_assembly $FLYE $LJA flye_vs_lja
compare_assembly $HIFIASM $LJA hifiasm_vs_lja