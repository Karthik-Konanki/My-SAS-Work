 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRRAPEAR                                           |
   |   TITLE: GRRAPEAR-Modifying the Appearance of Radar Charts  |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GRADAR                                    |
   |   PROCS: GRADAR                                             |
   |    DATA: SASHELP.FAILURE                                    |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 28FEB11              |
   | recoded to run in SAS Studio   UPDATE: 15MAY2020            |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

 /* For overlay charts with multiple stars, the lines for
    the stars are rotated through different line styles and
    colors so that the different stars can be easily seen.
    Rather than relying on the default rotation patterns, you
    can control the line colors, widths, and styles with the
    CSTARS=, LSTARS=, and WSTARS= options.
 */

 /* This example features the following options:

    CSTARS= specifies a different color for each of the star
            outlines in the chart.

    WSTARS= specifies the width in pixels of the outline of stars.

    LSTARS= specifies a solid line as the line style for each
            star outline.

    STARCIRCLES= determines that two reference circles are
            superimposed on the star charts. The value 1.0
            determines that a circle with a radius equal to the
            spoke length is displayed. The value 0.5 determines
            that a circle is displayed half way between the outer
            circle and the smallest circle (value 0.0) that could
            be drawn for the chart. The value 0.0 would display a
            circle at the minimum data value, which does not mean
            that it is actually 0. For example, for data values of
            4, 8, 10, and 12, STARCIRCLES=(0.0 1.0) would draw
            circles at 4 and 12.
 */

goptions reset=all border;
title "Capacitor Failures by Cleaning Process";

data failures;
set sashelp.failure (where=(count >0));
run;

proc gradar data=failures;
    chart cause /  freq=count
       overlayvar=process
       cstars=(red, blue)
       wstars=2 2
       lstars=1 1
       starcircles=(0.5 1.0)
       cstarcircles=ltgray;
run;
quit;
