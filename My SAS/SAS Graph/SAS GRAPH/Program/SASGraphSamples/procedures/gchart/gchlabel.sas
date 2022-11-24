/*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHLABEL                                    |
   |   TITLE: GCHLABEL-Ordering/Labeling Pie-Chart Slices |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART                             |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment */
goptions reset=all border;

 /* Define title. */
title 'Types of Vehicles Produced Worldwide';
/* footnote j=r 'GCHLABEL'; */

 /* Produce the pie chart.  This graph uses the data set
    entitled CARS found in the SASHELP library. OTHER=0
    specifies that all midpoints,  no matter how small,
    display a slice. MIDPOINTS= assigns the  order of the
    slices. Each slice displays the percent contribution to
    total production and the slice name. VALUE=NONE suppresses
    the chart statistic. Both SLICE= and PERCENT=
    are assigned the ARROW labeling method to point to the
    slice, but only one arrow line is displayed.  */

proc gchart data=sashelp.cars;
pie type / other=0
midpoints='Truck' 'SUV' 'Sedan' 'Wagon' 'Sports' 'Hybrid'
value=none
percent=arrow
slice=arrow
noheading;
run;
quit;
