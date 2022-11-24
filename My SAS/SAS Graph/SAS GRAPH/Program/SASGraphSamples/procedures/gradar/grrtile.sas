 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GRRTILE                                     |
   |   TITLE: GRRTILE-Tiling Radar Charts                 |
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

 /* As an alternative to overlaying multiple radar charts
    (see GRROVER), you can tile charts horizontally, vertically,
    or in both directions (see GRRTWOWY) using the ACROSSVAR=
    and/or DOWNVAR= options. Each cell in the output corresponds
    to a level of the classification variable. By default,
    the cells are arranged in alphabetical order of the values
    of the variable from top to bottom. The key cell is the left
    cell (corresponding to PROCESS = Process A in this example).

    The output in this example shows that the main difference in
    the frequencies for Process A and Process B is a drop in
    contamination using Process B.

    This example features the following options:

    ACROSSVAR= specifies variable PROCESS as the categorical
               variable whose values determine the number of
               charts that are tiled.

    STARLEGEND=CLOCK generates a legend that identifies spoke
               positions. Value CLOCK determines that the positions
               are identified using a clock metaphor.

    STARLEGENDLAB= specifies the category-legend label
                   Failure Causes.
 */

goptions reset=all border;
title "Capacitor Failures by Cleaning Process";

data failures;
set sashelp.failure (where=(count >0));
run;

proc gradar data=failures;
    chart cause / acrossvar=process
        freq=count
        starlegend=clock
        starlegendlab="Failure Causes";
run;
quit;
