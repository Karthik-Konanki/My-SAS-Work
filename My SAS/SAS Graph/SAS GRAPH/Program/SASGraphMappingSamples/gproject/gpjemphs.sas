 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJEMPHS                                           |
   |   TITLE: GPJEMPHS-Emphasizing Map Areas                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN       |
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSGFK.US_STATES                                  |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      | 
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create a reduced continental U.S. map data set and remove
   Alaska, Hawaii, and Puerto Rico. */
data us48;
   set mapsgfk.us_states;
   if state not in (2 15 72);
run;

/* Project the map onto a plane centered in the Pacific. */
proc gproject data=us48
              latlon
              degrees eastlong
              out=skew
              project=gnomon
              polelong=200
              polelat=50;
   id state;
run;

/* Define the title and footnote for the map. */
title "United States Map";
footnote j=r "GPJEMPHS ";

/* Define the pattern characteristics. */
pattern value=mempty color=blue;

/* Show the projected map. */
proc gmap map=skew data=skew all;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;