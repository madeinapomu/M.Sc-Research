#!/bin/sh
#SBATCH --job-name=trimming
#SBATCH --account=DA494
#SBATCH --partition=compute
#
#SBATCH --cpus-per-task=3
#SBATCH --time=08:00:00 
 
module purge
module load anvio


## Define variables here to be used below, input locations, outputs etc.
INPUT=/storage/osakintu/raw_data
OUTPUT=/storage/osakintu/raw_data_trimmomatic

## trimmomatic loop
for r1 in ${INPUT}/*_1.fastq.gz
   do
   name=$(basename ${r1} _1.fastq.gz)
   echo $name

   anvio trimmomatic PE -threads $SLURM_CPUS_PER_TASK ${INPUT}/${name}_1.fastq.gz ${INPUT}/${name}_2.fastq.gz ${OUTPUT}/${name}_trimmed_1.fastq.gz ${OUTPUT}/${name}_unpaired_1.fastq.gz ${OUTPUT}/${name}_trimmed_2.fastq.gz ${OUTPUT}/${name}_unpaired_2.fastq.gz \
   ILLUMINACLIP:/storage/osakintu/TrueSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3  SLIDINGWINDOW:4:30  MINLEN:20

done
