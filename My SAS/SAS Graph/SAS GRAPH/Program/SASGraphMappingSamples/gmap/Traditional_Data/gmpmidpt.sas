 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPMIDPT                                           |
   |   TITLE: GMPMIDPT-Using Traditional Map Data to Specify     |
   |                   Midpoints in a Prism Map                  |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP PRISM                           |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.AFRICA, SASHELP.DEMOGRAPHICS               |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define the title for the map */
title1 "Adult Literacy Rate";

   /* Identify lake regions in the map data */
data africa;
   set mapssas.africa;
   by id segment;
   if first.id then lake=0;
   if x=. then lake+1;
   retain lake;
run;

   /* Display the prism map */
proc gmap data=sashelp.demographics(where=(cont=94))
          map=africa(where=(lake=0)) density=low all;
   id id;
   format adultliteracypct percentn5.0;
   prism adultliteracypct / midpoints=.1 to .9 by .2
                            cdefault=yellow;
run;
quit;
