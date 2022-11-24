 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPSURFA                                           |
   |   TITLE: GMPSURFA-Using Traditional Map Data to Produce a   |
   |                   Simple Surface Map                        |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP                                 |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.SAMERICA, SASHELP.DEMOGRAPHICS             |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 08MAR2013      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define titles for the map */
title1 "Population Annual Growth Rate Percentage";
title2 "South America (1995-2005)";

   /* Display the surface map */
proc gmap map=mapssas.samerica data=sashelp.demographics;
   id id;
   surface popagr;
run;
quit;
