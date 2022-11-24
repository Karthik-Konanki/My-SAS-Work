 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPCHORO                                           |
   |   TITLE: GMPCHORO-Using Traditional Map Data to Produce a   |
   |                   Simple Choropleth Map                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP                                 |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.EUROPE, SASHELP.DEMOGRAPHICS               |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define title for the map */
title1 "Population in Europe";

   /* Display the choropleth map */
proc gmap map=mapssas.europe(where=(id ne 405 and id ne 845))
          data=sashelp.demographics(where=(cont=93)) all;
  id id;
  choro pop / cdefault=yellow;
run;
quit;
