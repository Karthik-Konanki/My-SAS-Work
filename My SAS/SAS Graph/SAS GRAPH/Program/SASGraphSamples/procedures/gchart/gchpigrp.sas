 /*+-----------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y        |
   |                                                     |
   |    NAME: GCHPIGRP                                   |
   |   TITLE: GCHPIGRP-Grouping and Arranging Pie Charts |
   | PRODUCT: GRAPH                                      |
   |  SYSTEM: ALL                                        |
   |    KEYS: GRAPHICS GCHART                            |
   |   PROCS: GCHART                                     |
   |    DATA: INTERNAL                                   |
   |                                                     |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011     |
   |     REF: SAS/GRAPH REFERENCE GUIDE                  |
   +-----------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /* define title for chart */
title "Types of Trucks Produced Worldwide";
/* footnote j=r "GCHPIGRP"; */


   /* generate pie chart */
proc gchart data=sashelp.cars(where=(type="SUV" or type="Truck"));
  pie make / group=type
             across=2
             other=5 otherlabel="Other Makes"
             clockwise value=none
             slice=outside percent=outside;
run;
quit;
