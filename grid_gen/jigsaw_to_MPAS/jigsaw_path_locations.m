function path = jigsaw_path_locations
% adds path locations to MATLAB path
% note need path to jigsaw-geo-matlab and jigsaw-geo-matlab/mesh-util in MATLAB path.
% need absolute paths here
base = '/usr/projects/climate/mpeterse/repos/jigsaw-geo-matlab/master/'
addpath([base])
addpath([base, 'dual-mesh/'])
addpath([base, 'jigsaw/'])
addpath([base, 'mesh-util/'])
end
