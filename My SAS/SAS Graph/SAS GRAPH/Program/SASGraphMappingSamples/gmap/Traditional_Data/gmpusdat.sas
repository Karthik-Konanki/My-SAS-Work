  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPUSDAT                                                    |
   |   TITLE: GMPUSDAT- Combining Traditional and Sample Map Data to Map  |
   |                    U.S. Population Statistics                        |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP CHORO SASHELP.US_DATA                    |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSSAS.US, SASHELP.US_DATA                                 |
   | RELEASE: SAS Viya 2021.1.2 and later releases                        |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           UPDATED: 13JUN2021 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/

    /* Set the graphics environment */
goptions reset = all border;

    /* Define the title for the map */
title1 ls=1.5 "Using Sample U.S. Response Data";

    /* Define the legend for the map */
legend1 label=(position=top) shape=bar(.1in,.1in);

    /* Produce the choropleth map of the United States */
    /* with 2020 population densities indicated per state */
proc gmap data=sashelp.us_data map=mapssas.us;
   id state;
   choro density_2020 / levels=3 legend=legend1;
run;
quit;
