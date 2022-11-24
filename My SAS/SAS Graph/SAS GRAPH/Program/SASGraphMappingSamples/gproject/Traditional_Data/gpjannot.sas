 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJANNOT                                           |
   |   TITLE: GPJANNOT-Projecting an Annotate Data Set           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN LATLON|
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSSAS.STATES, MAPSSAS.USCITY                     |
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

   /* Project the US48 data set */
proc gproject data=us48
              out=us48p
              project=gnomon
              polelong=160
              polelat=45
              parmout;
id state;
run;

   /* Create Annotate data set CITIES */
data cities;
   set mapssas.uscity(keep=lat long city state);
   length function style color $ 8
          position $ 1 text $ 20;
   retain function "label" xsys ysys "2"
          hsys "1" when "a";
   if (state=45 and city="Charleston") or
      (state=25 and city="Boston") or
      (state=23 and city="Bangor");
    state+100; color="black"; size=8;
      text="V";
      position="5";
      style="marker";
      output;
    state+1; color="black"; size=5;
      text="   "||city;
      position="6";
      style="swissb";
      output;
run;

   /* Project the annotate data set. */
proc gproject data=cities
              degrees
              latlon
              out=citiesp
              parmentry=us48p
              dupok;
id;
run;

   /* Define title for the map */
title1 'Distribution Center Locations';
title2 'East Coast';

   /* Define pattern characteristics */
pattern value=mempty color=blue;

   /* Display the annotated map */
proc gmap data=us48p map=us48p all;
   id state;
   choro state / nolegend levels=1 stat=first
                 annotate=citiesp;
run;
quit;
