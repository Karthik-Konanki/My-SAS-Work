
 /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPSTAT                                                     |
   |   TITLE: GMPSTAT- Using Traditional Map Data to Specify the Statistic|
   |                   for the Response Variable                          |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP BLOCK STATISTIC                          |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSSAS.US, SASHELP.ZIPCODE                                 |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                            UPDATE: 18MAY2020 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/

  /* Set the graphics environment */
goptions reset=all border;

  /* Create the title for the map */
title1 "Number of ZIP Codes per State";
pattern1 value=msolid color=tan;

  /* Create the block map */
proc gmap map=mapssas.us data=sashelp.zipcode all;
   id state;
   block zip / statistic=frequency
               levels=5 relzero;
run;
quit;
