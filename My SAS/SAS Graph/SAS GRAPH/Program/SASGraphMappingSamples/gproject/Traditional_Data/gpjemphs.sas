 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJEMPHS                                           |
   |   TITLE: GPJEMPHS-Emphasizing Map Areas                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN       |
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSSAS.STATES                                     |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAY2020      | 
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Create reduced continental U.S. map data set */
   /* and remove Alaska, Hawaii, and Puerto Rico   */
data us48;
   set mapssas.states;
   if state ne 2 and state ne 15 and state ne 72;
   if density<4;
run;

   /* Project map onto plane centered in the Pacific */
proc gproject data=us48
              out=skew
              project=gnomon
              polelong=160
              polelat=45;
   id state;
run;

   /* Define title and footnote for map */
title 'United States Map';
footnote j=r 'GPJEMPHS ';

   /* Define pattern characteristics */
pattern value=mempty color=blue;

   /* Show projected map */
proc gmap map=skew data=skew all;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;
