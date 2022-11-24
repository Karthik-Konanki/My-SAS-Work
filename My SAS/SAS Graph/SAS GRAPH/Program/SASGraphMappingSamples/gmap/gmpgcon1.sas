  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPGCON1                                                    |
   |   TITLE: GMPGCON1- Using GfK GeoMarketing Map Data to Specify Country|
   |                    Subdivisions on a Continent                       |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP CHORO STATISTIC                          |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSGFK.AFRICA1                                             |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           CREATED: 27JUL2012 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/
  /* Set the graphics environment */
goptions reset=all border;

  /* Create the titles and footnote for the map */
title1 j=c 'Africa:';
title2 j=c 'First-Level Administrative Country Subdivisions';
footnote1 j=r 'This map drawn with GfK map data';

/* Change the color in some indistinguishable areas */
pattern1 value=msolid color=CXD0F0C0;
pattern2 value=ms color=CXE6E6FA;
pattern3 value=ms color=CXE7FEFF;

/* Create the choropleth map */
proc gmap map=mapsgfk.africa1 data=mapsgfk.africa1;
   id isoalpha2 id; 
   choro isoalpha2/discrete nolegend stat=first;
run;
quit;
