 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPFORMT                                           |
   |   TITLE: GMPFORMT-Using Traditional Map Data to Assign a    |
   |                   Format to the Response Variable           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP PATTERN LEGEND                  |
   |   PROCS: GMAP SORT                                          |
   |    DATA: MAPSSAS.ASIA, SASHELP.DEMOGRAPHICS                 |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;


   /* Create the format for the POP variable */
proc format;
  value popfmt low-1000000="0-1"
               1000001-10000000="1-10"
               10000001-100000000="10-100"
               100000001-500000000="100-500"
               500000001-high="over 500";
run;

   /* Create the format for the REGION variable */
proc format;
  value $ regionfmt "SEAR" = "South-East Asia"
                    "EUR" = "Europe"
                    "EMR" = "Eastern Mediterranean"
                    "WPR" = "Western Pacific";
run;

   /* Define title and colors for the map */
title1 "Population Data for Asia (2005)";
pattern1 color=gold value=msolid;
pattern2 color=yellow value=msolid;
pattern3 color=cyan value=msolid;
pattern4 color=light_blue value=msolid;

   /* Assign legend label */
legend1 label=("Population (Millions)");

   /* Display the block map */
proc gmap data=sashelp.demographics(where=(cont=95))
          map=mapssas.asia all;
   format pop popfmt.;
   format region $regionfmt.;
   id id;
   area region / midpoints="SEAR" "EUR" "EMR" "WPR";
   block pop / legend=legend1
               relzero
               levels=all;
run;
quit;
