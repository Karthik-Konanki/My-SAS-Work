 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GANVBAR                                            |
   |   TITLE: GANVBAR-Labeling Subgroups in a Vertical Bar Chart |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS PATTERN ANNOTATE GCHART              |
   |   PROCS: GCHART                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 21APR2020      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:                                                    |
   |                                                             |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /*  create data set of units sold  */
data sold;
   length type $ 10;
   input city $ units type $ ;
   datalines;
Atlanta  99 Printers
Atlanta 105 Plotters
Atlanta  85 Terminals
Paris   182 Printers
Paris   150 Plotters
Paris   157 Terminals
Sydney  111 Printers
Sydney  136 Plotters
Sydney  100 Terminals
;

   /* create the Annotate data set, BARLABEL */
data barlabel;
   length color style $ 12;
   retain color 'white' when 'a' style 'Albany AMT'
      xsys ysys '2' position 'E' size 4 hsys '3';
   set sold;
   midpoint=city;
   subgroup=type;
   text=left(put(units,5.));
run;

   /* define the title and footnote */
title 'Orders Received';
footnote j=r 'GANVBAR';

   /* define axis characteristics */
axis1 label=none major=none minor=none style=0
      value=none;
axis2 label=none;

   /* generate vertical bar chart */
   /* using the Annotate data set */
proc gchart data=sold;
   vbar city / type=sum
               sumvar=units
               subgroup=type
               width=17
               raxis=axis1
               maxis=axis2
               annotate=barlabel
               noframe;
run;
quit;
