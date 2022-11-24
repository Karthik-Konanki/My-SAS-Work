 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJDEFLT                                           |
   |   TITLE: GPJDEFLT-Using Default Projection Specs in a Map   |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN       |
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSGFK.US_STATES                                  |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create a reduced continental U.S. map data set that excludes
   Alaska, Hawaii, and Puerto Rico. */
data us48unproj;
   set mapsgfk.us_states;
   if state not in (2 15 72);
   drop x y;
   rename long=x lat=y;
run;

/* Define the title for the unprojected map. */
title "United States Map: Unprojected";

/* Define the pattern characteristics. */
pattern value=mempty color=blue;

/* Show the unprojected map. */
proc gmap map=us48unproj data=us48unproj all;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;

/* Project the map data set using the default method. */
proc gproject data=us48unproj out=us48proj degrees eastlong;
   id state;
run;

/* Show the projected map. */
title "United States Map: Albers Eastlong Projection";
proc gmap map=us48proj data=us48proj all density=4;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;