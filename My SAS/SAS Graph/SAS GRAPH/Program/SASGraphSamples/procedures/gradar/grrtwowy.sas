 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GRRTWOWY                                    |
   |   TITLE: GRRTWOWY-Multiple Variables in Radar Charts |
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

 /* You can study the effects of two classifications
    simultaneously with a two-way comparative radar chart.
    This arrangement provides the opportunity to discover
    both one-way marginal effects and interaction effects.
    To produce the chart, use both the ACROSSVAR= and
    DOWNVAR= options.

    This example features the following options:

    ACROSSVAR= specifies variable DAY as the variable whose
               values determine the rows in the chart matrix.

    DOWNVAR= specifies variable PROCESS as the variable whose
             values determine the columns in the chart matrix.

    STARTYPE= determines that the stars are displayed with
              rays emanating from the inner circle.

    NROWS= and NCOLS= specify the number of rows and columns
                      in the chart.

    STARLEGEND= specifies the style of the legend.
 */

goptions reset=all border;
title "Capacitor Failures by Cleaning Process and Day";

data failures;
set sashelp.failure (where=(count >0));
run;

proc gradar data=failures;
    chart cause / acrossvar=day
        downvar=process
        freq=count
        startype=spoke
        nrows=2 ncols=5
        starlegend=clock;
run;
quit;
