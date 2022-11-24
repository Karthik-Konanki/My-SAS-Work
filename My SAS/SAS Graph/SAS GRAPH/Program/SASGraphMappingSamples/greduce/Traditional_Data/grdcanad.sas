 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRDCANAD                                           |
   |   TITLE: GRDCANAD-Reducing the Map of Canada                |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GREDUCE MAPS PATTERN        |
   |   PROCS: GMAP GREDUCE                                       |
   |    DATA: MAPSSAS.CANADA2                                    |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment. */
goptions reset=all border;

   /* Define the title for the first map */
title1 'Canada';
title2 'Using all DENSITY values';

   /* Define pattern characteristics */
pattern value=msolid repeat=13 color=white;

   /* Show the unreduced map */
proc gmap map=mapssas.canada2 data=mapssas.canada2 all;
   id province;
   choro province / statistic=first nolegend coutline=blue;
run;

   /* Create the map data set CAN2 using */
   /* the GREDUCE procedure              */
proc greduce data=mapssas.canada2 out=can2;
   id province;
run;

   /* Define new title for the second map */
title2 'Using only DENSITY values 0 to 2';

   /* Show reduced map with density levels 0-2 */
proc gmap map=can2 data=can2
          all density=2;
   id province;
   choro province / statistic=first nolegend coutline=blue;
run;
quit;
