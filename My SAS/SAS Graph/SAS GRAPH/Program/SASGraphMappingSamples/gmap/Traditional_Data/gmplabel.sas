 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPLABEL                                           |
   |   TITLE: GMPLABEL-Using Traditional Map Data to Label       |
   |                   Provinces on a Map                        |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP ANNOTATE                        |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSSAS.BELARUS                                    |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 18MAY2020      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment */
goptions reset=all border;

   /* Define the title for the map */
title "Labeling Provinces with the MAPLABEL Macro";

   /* Define pattern characteristics */
pattern1 value=empty color=blue repeat=6;

   /* The %MAPLABEL macro calculates the centroid and
       creates the Annotate data set.*/
%annomac;  /* enables the annotate macros */
%maplabel (mapssas.belarus, mapssas.belarus2, work.labelout, 
           idname, id,
           font=Albany AMT/Bold, color=violet, size=4, hsys=3);

   /* Display the choropleth map */
proc gmap map=mapssas.belarus data=mapssas.belarus;
   id id;
   choro id / stat=sum nolegend annotate=labelout;
run;
quit;
