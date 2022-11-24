 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRMAFRIC                                           |
   |   TITLE: GRMAFRIC-Creating an Outline Map of Africa         |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GREMOVE MAPS PATTERN        |
   |   PROCS: GMAP GREMOVE                                       |
   |    DATA: MAPSSAS.AFRICA                                     |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

    /* Create data set NEWAF */
data newaf;
   set mapssas.africa;
   region=1;
run;

   /* Remove the unit areas from the AFRICA data set */
proc gremove data=newaf out=africa;
   by region;
   id id;
run;

   /* Define title and footnote */
title 'Africa with Boundaries';
footnote j=r 'GRMAFRIC(a) ';

   /* Define pattern characteristics */
pattern value=mempty color=blue;

   /* Display the original map */
proc gmap map=mapssas.africa data=mapssas.africa all;
   id id;
   choro id / statistic=first nolegend levels=1;
run;

   /* Define new title and footnote for map */
title 'Africa without Boundaries';
footnote j=r 'GRMAFRIC(b) ';

   /* Display the map */
proc gmap data=africa map=africa;
   id region;
   choro region / statistic=first nolegend levels=1;
run;
quit;
