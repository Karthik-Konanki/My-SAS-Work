  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPGCONC                                                    |
   |   TITLE: GMPGCONC- Using GfK GeoMarketing Map Data to Produce a      |
   |                    Choropleth Map Combining 3 Map Data Sets          |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP CHORO STATISTIC                          |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSGFK.AUSTRIA, MAPSGFK.CZECH, MAPSGFK.HUNGARY             |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           CREATED: 27JUL2012 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/
  /* Specify the countries to combine */
data all;
   length name $18;
   set mapsgfk.austria(in=k1) mapsgfk.czech_republic(in=k2) mapsgfk.hungary;
   if k1 then name='Austria';
   else if k2 then name='Czech Republic';
      else name='Hungary';
   x=long;
   y=lat;
run;

  /* Project the map and store the projection parameters */

proc gproject data=all out=map degrees eastlong parmout;
   id name id;
run;

  /* Set the graphics environment */
goptions reset=all border;

  /* Define the title, footnote, and legend for the map */
title1 "Combining 3 Map Data Sets";
footnote j=r "This map drawn with GfK map data";
legend1 label=("Country Name:");

  /* Display the choropleth map combining 3 European countries */
proc gmap map=map data=map;
   id name id; 
   choro name/discrete stat=first legend=legend1;
run;
quit;
