#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=yannick.jauslin@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/yjauslin/output_jellyfish_%j.o
#SBATCH --error=/data/users/yjauslin/error_jellyfish_%j.e
#SBATCH --partition=pibu_el8

READS_DIR=/data/users/${USER}/assembly_annotation_course/Hiroshima
OUT_DIR=/data/users/${USER}/assembly_annotation_course/kmer_counts

mkdir $OUT_DIR

cd $READS_DIR

module load Jellyfish/2.3.0-GCC-10.3.0

jellyfish count \
-C -m 21 -s 5G -t 4 \
<(zcat *.fastq.gz)\
 -o $OUT_DIR/reads.jf

cd $OUT_DIR

jellyfish histo -t 4 reads.jf > reads.histo