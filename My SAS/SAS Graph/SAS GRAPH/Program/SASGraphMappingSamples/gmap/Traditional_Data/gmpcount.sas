 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPCOUNT                                           |
   |   TITLE: GMPCOUNT- Mapping an Individual Country            |
   |                    by Subsetting MAPS.WORLD                 |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP                                 |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.WORLD                                      |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

  /* Set the graphics environment */
goptions reset=all border;

  /* Enable the formats from the SASHELP.MAPFMTS catalog */
options fmtsearch=(sashelp.mapfmts);

  /* Subset the map data for the Bahamas from MAPS.WORLD by using *
   * the SQL procedure and the geographic locator code format     *
   * (glcnsm)                                                     */

proc sql;
   create table mymap as
      select * from mapssas.world
      where put(id,glcnsm.) eq "Bahamas";
;
run;

  /* Create the choropleth map by using the GMAP procedure */

proc gmap map=mymap data=mymap;
   format id glcnsm.;
   id id;
   choro id / stat=first;
run;
quit;
