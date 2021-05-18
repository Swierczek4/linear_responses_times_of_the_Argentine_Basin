#!/bin/bash

rm -f *.o
rm -f *.f

module purge
module load phdf5-intel
module swap intel/2020.4 intel/2020.1
module load netcdf-fortran/intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

make CLEAN
../../../tools/genmake2  "-mpi" "-mods" "../code" "-of" "../code/PUMA_build.sh"
make depend
make -j 4
