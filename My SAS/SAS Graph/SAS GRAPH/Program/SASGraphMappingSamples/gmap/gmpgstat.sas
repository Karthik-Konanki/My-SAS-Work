
 /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPGSTAT                                                    |
   |   TITLE: GMPGSTAT- Using GfK GeoMarketing Map Data to Specify the    |
   |                    Statistic for the Response Variable               |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP BLOCK STATISTIC                          |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSGFK.US, SASHELP.ZIPCODE                                 |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           CREATED: 06MAR2013 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Create the title, footnote, and color for the map */
title1 "Number of ZIP Codes per State";
footnote j=r "This map drawn with GfK map data";
pattern1 value=msolid color=tan;

   /* Create the block map */
proc gmap map=mapsgfk.us data=sashelp.zipcode all;
   id state;
   block zip / statistic=frequency levels=5 relzero;
run;
quit;
