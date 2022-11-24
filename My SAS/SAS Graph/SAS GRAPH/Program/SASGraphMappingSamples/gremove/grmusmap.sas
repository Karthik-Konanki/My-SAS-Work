 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRMUSMAP                                           |
   |   TITLE: GRMUSMAP-Removing State Boundaries from U.S. Map   |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GMAP GREMOVE MAPS PATTERN        |
   |   PROCS: GMAP GREMOVE SORT                                  |
   |    DATA: MAPSGFK.US                                         |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022      |
   |     REF: SAS/GRAPH & Base SAS MAPPING REFERENCE             |
   +-------------------------------------------------------------+*/

/* Create data set MY_MAP. */
data my_map; 
   set mapsgfk.us;
   original_order=_n_;
run;

/* Create a sorted data set, MY_MAP. */
proc sql noprint;
   create table my_map as
   select my_map.*, us_data.region
   from my_map left join sashelp.us_data
   on my_map.statecode=us_data.statecode
   order by region, statecode, original_order;
run;

/* Remove interior boundaries within regions. */
proc gremove data=my_map out=my_map;
   by region;
   id statecode;
run;

/* Define the title and footnote for the map. */
title "U.S. State Map";
footnote j=r "GRMUSMAP(a) ";

/* Define the state pattern characteristics. */
pattern value=s color=white;

/* Show the original map. */
proc gmap map=mapsgfk.us data=mapsgfk.us all;
   id state;
   choro segment / levels=1 nolegend
   des='' name="grmusmap";
run;

/* Define the new title and footnote for the map with state
   boundaries removed. */
title "U.S. Region Map";
footnote j=r "GRMUSMAP(b) ";

/* Reset the pattern to use the default color pattern before
   creating the map with state boundaries removed. */
goptions reset=pattern;

/* Show the regional map. */
proc gmap map=my_map data=sashelp.us_data all;
   id region;
   choro region / cdefault=red
   des='' name="grmusmap";
run;
quit;

/* Reset the graphics environment. */
goptions reset=all;