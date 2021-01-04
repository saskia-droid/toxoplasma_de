#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=index_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pcourse80
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-2

SAMPLES=("$@")

module add UHTS/Analysis/samtools/1.10

SORTED_BAM_FILE=/data/courses/rnaseq/toxoplasma_de/sperretgentil/map_reads/bam_files/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sorted.bam

samtools index ${SORTED_BAM_FILE}
