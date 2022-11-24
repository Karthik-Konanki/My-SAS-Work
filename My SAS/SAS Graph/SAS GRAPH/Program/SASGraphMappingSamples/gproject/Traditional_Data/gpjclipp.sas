 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPJCLIPP                                           |
   |   TITLE: GPJCLIPP-Clipping an Area from a Map               |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GPROJECT MAPS PATTERN       |
   |   PROCS: GMAP GPROJECT                                      |
   |    DATA: MAPSSAS.STATES                                     |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Clip and project rectangular subset of the map */
proc gproject data=mapssas.states
              out=gulf
              longmin=81
              longmax=98
              latmin=25
              latmax=33;
   where density<5;
   id state;
run;

   /* Define title and footnote for map */
title 'Northern Gulf Coast';
footnote j=r 'GPJCLIPP ';

   /* Define pattern characteristics */
pattern value=mempty color=blue;

   /* Show clipped map */
proc gmap map=gulf data=gulf all;
   id state;
   choro state / statistic=first nolegend levels=1;
run;
quit;
