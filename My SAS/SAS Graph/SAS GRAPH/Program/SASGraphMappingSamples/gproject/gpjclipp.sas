 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJCLIPP                                           |
   |   TITLE: GPJCLIPP-Clipping an Area from a Map               |
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
data us48;
   set mapsgfk.us_states;
   if state not in (2 15 72);
run;

/* Clip and project a rectangular subset of the map. */
proc gproject data=us48
              latlon
              degrees eastlong
              out=gulf
              longmin=-98
              longmax=-81
              latmin=25
              latmax=33;
   where density<5;
   id state;
run;

/* Define the title and footnote for the map. */
title "Northern Gulf Coast";
footnote j=r "GPJCLIPP ";

/* Define the pattern characteristics. */
pattern value=mempty color=blue;

/* Show the clipped map. */
proc gmap map=gulf data=gulf all;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;