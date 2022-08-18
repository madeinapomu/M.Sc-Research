#!/bin/sh
#SBATCH --job-name=centrifuge    #name of the Job i am runnig.
#SBATCH --account=da494      #my account that gives me access to use the HPC
#SBATCH --partition=compute  #partition name
#SBATCH --mem-per-cpu=8000   #requested memory for the analysis
#SBATCH --cpus-per-task=20    #numbers of core
#SBATCH --time=96:00:00      #max time limit allocated to run the script

module purge      #to unload all previus programm and resset everything
module load centrifuge #to load centrigufe

INPUT=/storage/osakintu/raw_data_trimmomatic #Input file
OUTPUT=/storage/osakintu/centrifuge-out      #output file

cd ${INPUT}                                  #change directory to the iput file

for r1 in *_trimmed_1.fastq.gz               #itirate through the lines in the file
   do
   name=$(basename ${r1} _1.fastq.gz)        # manupulate name to return the result 
   echo $name                                #return name

   centrifuge -p $SLURM_CPUS_PER_TASK -x /storage02/data/centrifuge-dbs/park-et-al-2020/hpvc -1 ${name}_1.fastq.gz -2 ${name}_2.fastq.gz -S ${OUTPUT}/${name}_centrifugeOutputs.txt --report-file ${OUTPUT}/${name}_centrifugeReport.txt
   humanReads=$(grep -i 'homo sapiens'$'\t''9606'$'\t' ${OUTPUT}/${name}_centrifugeReport.txt|sed 's/.*\t//g'); echo $humanReads > ${OUTPUT}/${name}_humanReadsProp.txt

done


