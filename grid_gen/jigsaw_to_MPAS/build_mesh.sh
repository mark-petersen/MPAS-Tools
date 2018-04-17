#!/usr/bin/env bash
# Directs process to build MPAS mesh using JIGSAW
# Mark R Petersen and Phillip J Wolfram, 01/19/2018
# Last updated 4/20/2018

# user defined commands and paths:
MATLAB='matlab -nodesktop -nodisplay -nosplash  -r'
MPASTOOLS='path/to/repo/MPAS-Tools'
JIGSAW='path/to/repo/jigsaw-geo-matlab'

# for Mark:
MATLAB='octave --silent --eval '
MPASTOOLS='/usr/projects/climate/mpeterse/repos/MPAS-Tools/master'
JIGSAW='/usr/projects/climate/mpeterse/repos/jigsaw-geo-matlab/master'

# fill in longer paths, based on paths above:
JIGSAW2NETCDF=$MPASTOOLS/grid_gen/triangle_jigsaw_to_netcdf/
MESHCONVERTER=$MPASTOOLS/grid_gen/mesh_conversion_tools/MpasMeshConverter.x
CELLCULLER=$MPASTOOLS/grid_gen/mesh_conversion_tools/MpasCellCuller.x

# First argument to this shell script is the name of the mesh
MESHNAME=$1
if [ -f define_mesh/${MESHNAME}.m ]; then
   echo 'Starting workflow to build mesh from ${MESHNAME}.m'
else
   echo "File define_mesh/${MESHNAME}.m does not exist."
	 echo "call using:"
	 echo "   build_mesh.sh meshname"
	 echo "where meshname is from define_mesh/*.m, as follows:"
	 ls define_mesh
	 exit
fi

echo 'Build mesh using JIGSAW ...'
CMD='try, run('"'$NAME.m'"'), catch, exit(1), end, exit(0);' # delete later
echo $MATLAB "driver_jigsaw_to_mpas('$MESHNAME')"
$MATLAB "driver_jigsaw_to_mpas('$MESHNAME')"
echo 'done'
exit

echo 'Convert to netcdf file (grid.nc) ...'
python $JIGSAW2NETCDF/triangle_jigsaw_to_netcdf.py -m ${NAME}-MESH.msh -s
echo 'done'

echo 'Convert to MPAS mesh (mesh.nc) ...'
$MESHCONVERTER grid.nc
echo 'done'

echo 'Removing grid.nc and renaming mesh.nc to '$NAME'.nc ...'
rm grid.nc
mv mesh.nc $NAME.nc
echo 'done'

echo 'Injecting bathymetry ...'
$JIGSAW2NETCDF/inject_bathymetry.py $NAME.nc
echo 'done'

echo 'Culling cells...'
$CELLCULLER $NAME.nc
mv culled_mesh.nc $NAME.nc
echo 'done'

echo 'Injecting bathymetry ...'
$JIGSAW2NETCDF/inject_bathymetry.py $NAME.nc
echo 'done'
