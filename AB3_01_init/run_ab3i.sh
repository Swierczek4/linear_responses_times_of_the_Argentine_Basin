#!/bin/bash
 
# --------------------------------------------------------------
### PART 1: Requests resources to run your job.
# --------------------------------------------------------------
#SBATCH --job-name=AB3_init
#SBATCH --output=%x-%j.out
#SBATCH --account=jrussell
#SBATCH --qos=user_qos_jrussell
#SBATCH --mail-type=ALL
#SBATCH --mail-user=swierczek@email.arizona.edu
#SBATCH --partition=standard
### SBATCH --mem=470gb
#SBATCH --time=10:00:00 
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=5gb

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB3_01_init/

cp build/makescript_AB3_01.sh run/

rm -rf build/*

mv run/makescript_AB3_01.sh build/

rm -rf AB3_init.*

cd run

rm -rf out*
rm -rf scratch*
rm -rf STD*
rm -rf Rho*
rm -rf wunit*
rm -rf XC*
rm -rf XG*
rm -rf DX*
rm -rf DY*
rm -rf mask*
rm -rf hFa*
rm -rf meta*
rm -rf RA*
rm -rf RF*
rm -rf RC*
rm -rf mitgcmuv
rm -rf DRF*
rm -rf Depth*
cd ..
rm -rf diag/*

cp input/* run/

cd build
. makescript_AB3_01.sh

module purge
module load phdf5-intel
module load netcdf-fortran/intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

### set directory for job execution, ~netid = home directory path

cd ..
cp build/mitgcmuv run/

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB3_01_init/run

###
### setenv MPI_DSM_DISTRIBUTE

### run your executable program with begin and end date and time output

srun --ntasks 24 ./mitgcmuv > output.txt



