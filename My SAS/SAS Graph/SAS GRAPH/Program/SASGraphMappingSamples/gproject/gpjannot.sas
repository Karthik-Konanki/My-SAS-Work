 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJANNOT                                           |
   |   TITLE: GPJANNOT-Projecting an Annotate Data Set           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN LATLON|
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSGFK.US_STATES, MAPSGFK.USCITY                  |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create a reduced continental U.S. map data set that excludes
   Alaska, Hawaii, and Puerto Rico. */
data us48;
   set mapsgfk.us_states;
   if state not in (2 15 72);
run;

/* Project the US48 data set. */
proc gproject data=us48 
              out=us48p
              latlon
              degrees eastlong
              project=gnomon
              polelong=200
              polelat=50
              parmout;
id state;
run;

/* Create the Annotate data set CITIES from the MAPSGFK.USCITY
   data set. */
data cities;
   set mapsgfk.uscity(keep=lat long city state);
   length function style color $ 15
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
      text="     "||city;
      position="C"; 
      style="Albany AMT/Bo"; 
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

/* Define the titles for the map. */
title1 "Distribution Center Locations";
title2 "East Coast";

/* Define the pattern characteristics. */
pattern value=mempty color=blue;

/* Display the annotated map. */
proc gmap data=us48p map=us48p all;
   id state;
   choro state / nolegend levels=1 statistic=first
                 annotate=citiesp;
run;
quit;