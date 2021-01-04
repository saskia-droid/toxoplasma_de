#!/bin/bash

#SBATCH --job-name=fastqc_toxo
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/sperretgentil/reads_quality/outputs_errors/%j.out
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/sperretgentil/reads_quality/outputs_errors/%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=02:00:00
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pcourse80

# add software to environment
module add UHTS/Quality_control/fastqc/0.11.7

READ_DIR=/data/courses/rnaseq/toxoplasma_de/reads
OUT_DIR=/data/courses/rnaseq/toxoplasma_de/sperretgentil/reads_quality

fastqc --outdir $OUT_DIR $READ_DIR/*.fastq.gz --threads 1
