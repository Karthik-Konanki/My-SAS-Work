  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                          |
   |    NAME: SGMPURL                                                      |
   |   TITLE: SGMPURL  U.S. State Map with Active URL Links                |
   |                                                                       |
   |  PRODUCT: BASE                                                        |
   |  SYSTEM: ALL                                                          |
   |    KEYS: GRAPHICS CHOROMAP SGMAP URL=                                 |
   |   PROCS: SGMAP                                                        |
   |    DATA: MAPSGFK.US                                                   |
   | RELEASE: SAS Viya 2021.1.4 and later releases                         |
   |                                                                       |
   | SUPPORT: GRAPHICS STAFF   UPDATE: AUG2021                             |
   | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                              |
   +---------------------------------------------------------------------+*/

/* Specify the graphics options. */
ods graphics / 
   imagemap
   width=500px height=375px
   drilltarget="_blank";

/* Assign a title to the graph. */
title1 h=20pt "Click State to Link to State Home Page";

data my_data; 
   set sashelp.us_data;
   length my_link $100;
   my_link='https://www.google.com/search?q=home+page+state+of'||
   trim(left(statecode));
run;

/* Generate the choropleth U.S. map with hot links */
proc sgmap maprespdata=my_data mapdata=mapsgfk.us noautolegend;
   choromap population_2020 / 
      mapid=statecode 
      id=statecode 
      url=my_link
      tip=(statename population_2020)
      tiplabel=("State" "Population");
run;