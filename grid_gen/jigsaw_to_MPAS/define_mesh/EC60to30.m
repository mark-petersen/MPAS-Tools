function [gridCellSizeGlobal,lon,lat] = EC60to30

   ddeg = 1;
   lat = [ -90:ddeg: 90]';
   lon = [-180:ddeg:180]';
 
   EC60to30 = EC_CellWidthVsLat(lat);
   gridCellSizeGlobal = EC60to30*ones([1, length(lon)]);
