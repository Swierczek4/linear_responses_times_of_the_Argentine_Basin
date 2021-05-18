#!/bin/bash
 
# --------------------------------------------------------------
### PART 1: Requests resources to run your job.
# --------------------------------------------------------------
#SBATCH --job-name=AB3_snpert
#SBATCH --output=%x-%j.out
#SBATCH --account=jrussell
#SBATCH --qos=user_qos_jrussell
#SBATCH --mail-type=ALL
#SBATCH --mail-user=swierczek@email.arizona.edu
#SBATCH --partition=standard
### SBATCH --mem=470gb
#SBATCH --time=100:00:00 
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=5gb

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB3_06_npert/

cp build/makescript_AB3_04.sh run/

rm -rf build/*
rm *.out

mv run/makescript_AB3_04.sh build/

rm -rf AB3_npert.*

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
rm -rf diag_state/*
rm -rf diag_surf/*
rm -rf diag_bgc/*
rm -rf diag_bio/*
rm -rf diag_airsea/*

cp input/* run/

cd build
. makescript_AB3_04.sh

module purge
module load phdf5-intel
module load netcdf-fortran/intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

### set directory for job execution, ~netid = home directory path

cd ..
cp build/mitgcmuv run/

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB3_06_npert/run

###
### setenv MPI_DSM_DISTRIBUTE

### run your executable program with begin and end date and time output

srun --ntasks 24 ./mitgcmuv > output.txt



