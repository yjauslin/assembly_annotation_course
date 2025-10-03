# Assembly Annotation Course

## Description

This repository was created to store sripts created during the assembly annotation course of the University of Bern. 
The code found in the scripts folder can be used to perform an entire genome assembly. In order to do so execute each file on the cluster starting with the tiniest number. Files with a letter after the number e.g. 04a_runFlye.sh constitute alternative paths. If preferred only one of those files can be run. However this enforces modifications in the latter scripts
Please be aware that you may need to change some of the file paths to not receive any error messages. 

## Structure

### Scripts/
- **[01_runFastQC.sh](scripts/01_runFastQC.sh)**:             evaluates quality of the reads using FastQC
- **[02_runFastp.sh](scripts/02_runFastp.sh)**:               trim end of reads and filter out bad quality reads using fastp
- **[03_countKmer.sh](scripts/03_countKmer.sh)**:             analyze and count kmers
- **[04a_runFlye.sh](scripts/04a_runFlye.sh)**:               assemble genome using flye
- **[04b_runHifiasm.sh](scripts/04b_runHifiasm.sh)**:         assemble genome using hifiasm
- **[04c_runLJA.sh](scripts/04c_runLJA.sh)**:                 assemble genome using LJA
- **[05_runTrinity.sh](scripts/05_runTrinity.sh)**:           assemble Transcriptome using Trinity
- **[06_runBusco.sh](scripts/06_runBusco.sh)**:               analyze assemblies with BUSCO
- **[07_runQuast.sh](scripts/07_runQuast.sh)**:               analyze and compare assemblies with Quast
- **[08_getBestKmer.sh](scripts/08_getBestKmer.sh)**:         find out best Kmer size
- **[09_buildMeryldb.sh](scripts/09_buildMeryldb.sh)**:       build Meryldb for Merqury
- **[10_runMerqury.sh](scripts/10_runMerqury.sh)**:           analyze assemblies with Merqury
- **[11_runNucmerMummer.sh](scripts/11_runNucmerMummer.sh)**: create Dotplots comparing the different assemblies to one reference assembly and to the other created assemblies

## Dependencies

Below you can find a list with all the tools used during the assemblies including their versions in the parentheses. While newer versions may be able to accomplish the same results an errorfree analysis cannot be guaranteed.

- **[FastQC (v0.12.1)](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)**
- **[Fastp (v0.24.1)](https://github.com/OpenGene/fastp)**
- **[Jellyfish (v2.2.6)](https://github.com/gmarcais/Jellyfish)**
- **[Flye (v2.9.5)](https://github.com/mikolmogorov/Flye)**
- **[Hifiasm (v0.25.0)](https://github.com/chhylp123/hifiasm)**
- **[LJA (v0.2)](https://github.com/AntonBankevich/LJA)**
- **[Trinity (v2.15.1)](https://github.com/trinityrnaseq/trinityrnaseq/wiki)**
- **[BUSCO (v5.7.1)](https://busco.ezlab.org)**
- **[QUAST (v5.2.0)](https://github.com/ablab/quast)**
- **[Merqury (v1.3)](https://github.com/marbl/merqury)**
- **[MUMmer4 (v4.0.0)](https://github.com/mummer4/mummer)**
