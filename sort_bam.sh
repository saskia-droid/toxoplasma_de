#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000M
#SBATCH --time=01:00:00
#SBATCH --job-name=sort_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pcourse80
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-2

# launch with: sbatch sort_bam.sh SRR7821939 SRR7821949 SRR7821970

SAMPLES=("$@")

module add UHTS/Analysis/samtools/1.10

BAM_FILE=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/bam_files/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.bam
SORTED_BAM_FILE=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/bam_files/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sorted.bam

samtools sort -m 25000M -@ 4 -o ${SORTED_BAM_FILE} -T temp ${BAM_FILE}
