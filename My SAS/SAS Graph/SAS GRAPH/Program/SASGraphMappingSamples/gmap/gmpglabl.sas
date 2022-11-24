 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPGLABL                                           |
   |   TITLE: GMPGLABL-Using GfK GeoMarketing Map Data to Label  |
   |                   Provinces on a Map                        |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP ANNOTATE                        |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSGFK.BELARUS                                    |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define the title and footnote for the map */
title "Labeling Provinces with the MAPLABEL Macro";
footnote j=r "This map drawn with GfK map data";

   /* Sort the GfK data by region and district variables */
proc sort data=mapsgfk.belarus out=belarus;
   by id1 id;
run;

   /* Remove country's internal boundaries for maplabel to get */
   /* centroid of each province and thus center each label     */
proc gremove data=belarus out=belarus_outline;
   by id1;
   id id;
run;

   /* The output data set from GREMOVE is used by the
       %MAPLABEL macro to determine the centroid of each
       province for positioning the province label                      */
%annomac;                     /* enables the annotate macros */
%maplabel (belarus_outline, mapsgfk.belarus_attr, work.labelout,
           id1name, id1, font=Albany AMT/Bold, color=black,
           size=2.5, hsys=3);

   /* Define fill pattern colors for the provinces */
pattern1 c=lightblue;
pattern2 c=lightcyan;
pattern3 c=lightpink;
pattern4 c=lightgreen;
pattern5 c=lightttan;
pattern6 c=lightyellow;
pattern7 c=lightgrey;

   /* Display the choropleth map */
proc gmap map=belarus data=belarus;
   id id1 id;
   choro id1 / nolegend annotate=labelout coutline=gray stat=first;
run;
quit;
