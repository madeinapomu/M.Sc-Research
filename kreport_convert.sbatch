#!/bin/sh
#SBATCH --job-name=kreport_convert
#SBATCH --account=da494
#SBATCH --partition=compute
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00 

module purge 
module load centrifuge

INPUT=/storage/osakintu/centrifuge-out
OUTPUT=/storage/osakintu/kreport_out

cd ${INPUT}

for r1 in *_trimmed_centrifugeReport.txt
   do
   name=$(basename ${r1} _trimmed_centrifugeReport.txt)
   echo $name
   perl /storage/osakintu/centrifuge-kreport -x /storage02/data/centrifuge-dbs/park-et-al-2020/hpvc ${INPUT}/${r1} >> ${OUTPUT}/${name}_kreport.txt
done

