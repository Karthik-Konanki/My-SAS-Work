 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPLEVEL                                           |
   |   TITLE: GMPLEVEL-Using Traditional Map Data to Specify     |
   |                   Response Levels in a Block Map            |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP PATTERN LEGEND                  |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.SAMERICA, SASHELP.DEMOGRAPHICS             |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/


   /* Set the graphics environment */
goptions reset=all border;

   /* Define the titles and the color for the map */
title1 "Gross National Income per Capita";
title2 "South America";
pattern1 value=msolid color=tan;

   /* Display the block map */
proc gmap data=sashelp.demographics(where=(cont=92))
          map=mapssas.samerica all;
   id id;
   block gni / levels=3 shape=prism
               relzero cempty=gray;
run;
quit;
