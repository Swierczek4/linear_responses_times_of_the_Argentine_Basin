#!/bin/bash
#PBS -N AB12_pert
#PBS -m bea
#PBS -M swierczek@email.arizona.edu
#PBS -W group_list=jrussell
#PBS -q windfall
###PBS -r n
###PBS -l jobtype=large_mpi
###PBS -l jobtype=cluster_only
#PBS -l select=12:ncpus=28:mem=168gb
#PBS -l place=free:shared
### Specify "wallclock time" required for this job, hhh:mm:ss
#PBS -l walltime=200:00:00

### Specify total cpu time required for this job, hhh:mm:ss
### total cputime = walltime * ncpus
#PBS -l cput=67200:00:00

#PBS -l pvmem=299gb

cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB12_03_pert/

cp build/makescript_AB12_03oce.sh run/
cp build/makescript_AB12_03.sh run/

rm -rf build/*

mv run/makescript_AB12_03oce.sh build/
mv run/makescript_AB12_03.sh build/

rm -rf AB12_pert.e*
rm -rf AB12_pert.o*

cd run

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
# rm -rf diag/*
# rm -rf diag_bio/*
# rm -rf diag_state/*
# rm -rf diag_airsea/*
# rm -rf diag_bgc/*

cp input/* run/

cd build

# source ~/.bashrc
module load intel/compiler
module load netcdf/fortran/intel
module load blas/intel
module load intel/mpi
###  LD_LIBRARY_PATH=/cm/shared/apps/intel/compilers_and_libraries/2016.2.181/mkl/lib/intel64_lin:$LD_LIBRARY_PATH

./makescript_AB12_03oce.sh

cd ..
cp build/mitgcmuv run/

### set directory for job execution, ~netid = home directory path
cd /xdisk/jrussell/mig2020/rsgrps/jrussell/swierczek/MITgcm/verification/AB12_03_pert/run

###
setenv MPI_DSM_DISTRIBUTE

### run your executable program with begin and end date and time output
date
 /usr/bin/time mpirun -np 336 ./mitgcmuv > output.txt
date



