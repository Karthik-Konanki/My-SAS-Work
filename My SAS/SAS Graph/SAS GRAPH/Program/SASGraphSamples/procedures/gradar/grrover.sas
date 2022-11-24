 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GRROVER                                     |
   |   TITLE: GRROVER-Overlaying Radar Charts             |
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

 /* The most typical way that radar charts are displayed is
    to overlay the charts on top of each other. To produce an
    overlay chart, use the OVERLAY= option on the CHART
    statement. On OVERLAY=, specify a classification variable
    whose values will determine the charts to be overlaid.
    This example shows two blocks of code. For overlay charts
    with multiple stars, the lines for the stars are rotated
    through different colors so that the different stars can
    be easily seen.

    In the following example, OVERLAY= specifies variable
    DAY as the overlay variable.
 */

goptions reset=all border;
title "Capacitor Failures by Cleaning Process";

data failures;
set sashelp.failure (where=(count >0));
run;

proc gradar data=failures;
    chart cause / freq=count
        overlayvar=process;
run;
quit;
