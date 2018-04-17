function RRS_CellWidth = RRS_CellWidthVsLat(latitude, cellWidthEq, cellWidthPole)
% RRS_CellWidthVsLat - Create Rossby Radius Scaling as a function of latitude.
% This is intended as part of the workflow to make an MPAS global mesh.
%
% Syntax: RRS_CellWidth = RRS_CellWidthVsLat(latitude, cellWidthEq, cellWidthPole)
%
% Inputs:
%    latitude - vector of length n, with entries between -90 and 90, degrees
%    cellWidthEq - Cell width at the equator, km
%    cellWidthPole - Cell width at the poles, km
%
% Outputs:
%    RRS_CellWidth - vector of length n, entrie are cell width as a function of latitude
%
% Example: 
%    RRS18to6 = RRS_CellWidthVsLat(latitude,18,6)
%
% See also: RRS_CellWidth

% Author: Mark Petersen
% Los Alamos National Laboratory
% March 2018; Last revision: 3/27/2018

degToRad = pi/180.0; % convert degrees to radians
gamma = (cellWidthPole/cellWidthEq)^4;  % ratio between high and low resolution
densityRRS = zeros(size(latitude));
RRS_CellWidth = zeros(size(latitude));
for j=1:length(latitude)
  densityRRS(j) = (1.0-gamma)*sin(abs(latitude(j))*degToRad)^4 + gamma;
  RRS_CellWidth(j) = cellWidthPole/densityRRS(j)^0.25;
end
