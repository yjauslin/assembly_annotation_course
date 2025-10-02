# Assembly Annotation Course

This repository was created to store sripts created during the assembly annotation course of the University of Bern. 
The code found in the scripts folder can be used to perform an entire genome assembly. In order to do so execute each file on the cluster starting with the tiniest number. Files with a letter after the number e.g. 04a_runFlye.sh constitute alternative paths. If preferred only one of those files can be run. However this enforces modifications in the latter scripts
Please be aware that you may need to change some of the file paths to not receive any error messages. 

## Structure

- Scripts:
- - **[01_runFastQC.sh](scripts/01_runFastQC.sh)**: evaluates quality of the reads using FastQC
  - **[02_runFastp.sh](scripts/02_runFastp.sh)**:
  - **[03_countKmer.sh](scripts/03_countKmer.sh)**:
  - **[04a_runFlye.sh](scripts/04a_runFlye.sh)**:
  - **[04b_runHifiasm.sh](scripts/04b_runHifiasm.sh)**:
  - **[04c_runLJA.sh](scripts/04c_runLJA.sh)**:
  - **[05_runTrinity.sh](scripts/05_runTrinity.sh)**:
  - **[06_runBusco.sh](scripts/06_runBusco.sh)**:
  - **[07_runQuast.sh](scripts/07_runQuast.sh)**:
  - **[08_getBestKmer.sh](scripts/08_getBestKmer.sh)**:
  - **[09_buildMeryldb.sh](scripts/09_buildMeryldb.sh)**:
  - **[10_runMerqury.sh](scripts/10_runMerqury.sh)**:
  - **[11_runNucmerMummer.sh](scripts/11_runNucmerMummer.sh)**:
