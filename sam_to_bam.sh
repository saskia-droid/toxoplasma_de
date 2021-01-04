#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=sam_to_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pcourse80
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-2

# Sample names as arguments (as array go from 0 to 2, have to give 3 arguments)
# launch with: sbatch sam_to_bam.sh SRR7821939 SRR7821949 SRR7821970
SAMPLES=("$@")

SAM_DIR=/data/courses/rnaseq/toxoplasma_de/mapping/
OUT_DIR=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/bam_files/

SAM_FILE=${SAM_DIR}${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sam
BAM_FILE=${OUT_DIR}${SAMPLES[$SLURM_ARRAY_TASK_ID]}.bam

# convert sam files to bam format
module add UHTS/Analysis/samtools/1.10

samtools view -hbS ${SAM_FILE} > ${BAM_FILE}
