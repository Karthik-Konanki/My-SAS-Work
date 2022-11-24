 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRMAFRIC                                           |
   |   TITLE: GRMAFRIC-Creating an Outline Map of Africa         |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GREMOVE MAPS PATTERN        |
   |   PROCS: GMAP GREMOVE                                       |
   |    DATA: MAPSGFK.AFRICA                                     |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create the NEWAF data set. */
data newaf;
   set mapsgfk.africa;
   region=1;
run;

/* Remove the unit areas from the AFRICA data set. */
proc gremove data=newaf out=africa;
   by region;
   id id;
run;

/* Define the title and footnote. */
title "Africa with Boundaries";
footnote j=r "GRMAFRIC(a) ";

/* Define pattern characteristics. */
pattern value=mempty color=blue;

/* Display the original map. */
proc gmap map=mapsgfk.africa data=mapsgfk.africa all;
   id id;
   choro segment / statistic=first nolegend levels=1;
run;
quit;

/* Define a new title and footnote for the map. */
title "Africa without Boundaries";
footnote j=r "GRMAFRIC(b) ";

/* Display the map with no boundaries. */
proc gmap data=africa map=africa;
   id region;
   choro region / statistic=first nolegend levels=1;
run;
quit;