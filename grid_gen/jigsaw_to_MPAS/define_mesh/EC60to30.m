function gridCellSizeGlobal = EC60to30(lon,lat)

    EC60to30 = EC_CellWidthVsLat(lat);
    gridCellSizeGlobal = EC60to30*ones([1, length(lon)]);
