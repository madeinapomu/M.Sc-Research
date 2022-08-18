#!/bin/sh
#SBATCH --job-name=fastqc    #name of the Job i am runnig.
#SBATCH --account=da494      #my account that gives me access to use the HPC	 
#SBATCH --partition=compute  #partition name
#SBATCH --mem-per-cpu=8000   #requested memory for the analysis 
#SBATCH --cpus-per-task=4    #numbers of core
#SBATCH --time=03:00:00      #max time limit allocated to run the script   

cd /storage/osakintu/raw_data  #change to file that contains the data
module load bioconda           #module to load bioconda where in have my factsqc
conda activate ancient_env     #the enviroment containing my data
fastqc ERR*                    #perform Fastqc on anything that start with "ERR"
mv *fastqc* /storage/osakintu/raw_data/raw_data_fastqc  #move my result to a new file
