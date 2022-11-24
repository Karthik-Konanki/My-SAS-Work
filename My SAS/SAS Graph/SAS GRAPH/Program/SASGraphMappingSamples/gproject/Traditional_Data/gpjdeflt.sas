 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJDEFLT                                           |
   |   TITLE: GPJDEFLT-Using Default Projection Specs in a Map   |
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
run;

   /* define title for unprojected map */
title 'United States Map';

   /* define pattern characteristics */
pattern value=mempty color=blue;

   /* show unprojected map */
proc gmap map=us48 data=us48 all density=4;
   id state;
   choro state / statistic=first nolegend levels=1;
run;

   /* project map data set using all default criteria */
proc gproject data=us48 out=us48proj;
   id state;
run;

   /* show projected map */
proc gmap map=us48proj data=us48proj all density=4;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;
