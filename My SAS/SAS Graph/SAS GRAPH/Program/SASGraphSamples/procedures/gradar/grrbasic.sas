 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GRRBASIC                                    |
   |   TITLE: GRRBASIC-Producing a Basic Radar Chart      |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GRADAR                             |
   |   PROCS: GRADAR                                      |
   |    DATA: SASHELP.FAILURE                             |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 28FEB11       |
   | recoded to run in SAS Studio   UPDATE: 15MAY2020     |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

 /* In a radar chart, the vertices are determined by the levels
    of a single variable, which is specified on the CHART
    statement. In this example, the variable CAUSE is specified
    as the chart variable. The spokes in the chart start at the
    twelve o'clock position and go in a clockwise order. The output
    shows that Contamination and Oxide Defects are the most
    frequently occurring problems. */

 /* The FREQ= option specifies variable COUNT to score vertex
    lengths. Thus, the values of COUNT weigh the contribution of
    each observation in the computation of the chart statistic. */

goptions reset=all border;
title "Capacitor Failures";

data failures;
set sashelp.failure (where=(count >0));
run;

proc gradar data=failures;
chart cause / freq=count;
run;
quit;
