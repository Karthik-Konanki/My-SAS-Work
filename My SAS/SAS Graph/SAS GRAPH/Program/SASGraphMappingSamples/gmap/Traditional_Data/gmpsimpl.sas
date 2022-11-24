 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPSIMPL                                           |
   |   TITLE: GMPSIMPL-Using Traditional Map Data to Produce a   |
   |                   Simple Block Map                          |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP PATTERN                         |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.ASIA, SASHELP.DEMOGRAPHICS                 |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define title for the map */
title1 "Population in Asia";
pattern1 value=msolid color=tan;


   /* Display the block map */
proc gmap data=sashelp.demographics(where=(cont=95))
          map=mapssas.asia all;
   id id;
   block pop / blocksize=1 relzero;
run;
quit;
