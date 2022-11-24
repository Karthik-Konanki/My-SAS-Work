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
   |    DATA: MAPGFK.WORLD                                       |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Set the graphics environment. */
goptions reset=all border;

/* Subset the MAPSGFK.WORLD map data set for the Bahamas by using
   the SQL procedure. */
proc sql;
   create table mymap as
      select * from mapsgfk.world
      where idname eq "Bahamas";
run;
quit;

/* Create the map by using the GMAP procedure. */
proc gmap map=mymap data=mymap density=6;
   id idname;
   choro idname / stat=first;
run;
quit;