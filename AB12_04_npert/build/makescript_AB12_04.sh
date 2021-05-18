#!/bin/bash

rm -f *.o
rm -f *.f

module purge
module load phdf5-intel
module load netcdf-fortran/intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

make CLEAN
../../../tools/genmake2  "-mpi" "-mods" "../code" "-of" "../code/PUMA_build.sh"
make depend
make -j 4