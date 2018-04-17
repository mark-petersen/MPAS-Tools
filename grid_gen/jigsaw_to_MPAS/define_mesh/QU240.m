function [cellWidthGlobal,lon,lat] = QU240

   ddeg = 10;
   lat = [ -90:ddeg: 90]';
   lon = [-180:ddeg:180]';

   cellWidthGlobal = 240*ones([length(lat) length(lon)]);
