 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRMUSMAP                                           |
   |   TITLE: GRMUSMAP-Removing State Boundaries from U.S. Map   |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GREMOVE MAPS PATTERN        |
   |   PROCS: GMAP GREMOVE SORT                                  |
   |    DATA: MAPSSAS.US                                         |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 28APR2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Create MY_MAP data set US STATES */
data my_map; set mapssas.us;
   original_order=_n_;
run;

   /* Sort data set into state regions */
proc sql noprint;
   create table my_map as
      select my_map.*, us_data.region
      from my_map left join sashelp.us_data
      on my_map.statecode=us_data.statecode
      order by region, statecode, original_order;
run;
quit;

   /* Remove interior boundaries within regions */
proc gremove data=my_map out=my_map;
   by region;
   id statecode;
run;

   /* Define title and footnote for map */
title 'U.S. State Map';
footnote j=r 'GRMUSMAP(a) ';

   /* Define pattern characteristics */
pattern value=s color=white;

   /* Show the original map */
proc gmap map=mapssas.us data=mapssas.us all;
   id state;
   choro segment / levels=1 nolegend
   des='' name="grmusmap";
run;
quit;

   /* Define new title and footnote for map */
title 'U.S. Region Map';
footnote j=r 'GRMUSMAP(b) ';

goptions reset=pattern;
   /* Show the regional map */
proc gmap map=my_map data=sashelp.us_data all;
   id region;
   choro region / cdefault=red
   des='' name="grmusmap";
run;
quit;


