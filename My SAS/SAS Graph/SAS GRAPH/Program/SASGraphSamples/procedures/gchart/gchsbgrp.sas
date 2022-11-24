/*+-------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y          |
   |                                                       |
   |    NAME: GCHSBGRP                                     |
   |   TITLE: GCHSBGRP-Subgrouping a Donut or Pie Chart    |
   | PRODUCT: GRAPH                                        |
   |  SYSTEM: ALL                                          |
   |    KEYS: GRAPHICS GCHART                              |
   |   PROCS: GCHART                                       |
   |    DATA: INTERNAL                                     |
   |                                                       |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                    |
   +-------------------------------------------------------+*/

/* Set the graphics environment with a black border */
goptions reset=all border;

 /* Create data set TOTALS. TOTALS contains quarterly sales
    data for  three manufacturing sites for one year. Sales
    figures are broken down by department . */
data totals;
length dept $ 7 site $ 8;
input dept site quarter sales;
datalines;
Parts Sydney 1 7043.97
Parts Atlanta 1 8225.26
Parts Paris 1 5543.97
Tools Sydney 4 1775.74
Tools Atlanta 4 3424.19
Tools Paris 4 6914.25
;

 /* Define title */

title 'Sales by Site and Department';
/* footnote j=r 'GCHSBGRP '; */

 /* Modify the subgroup legend. LABEL= suppresses the legend label.
 POSITION=, OFFSET=, and ACROSS= arrange the legend entries in
 a column to the left of the pie chart.
 MODE= allows the legend to occupy the procedure output area. */

legend1 label=none
position=(middle left)
offset=(5,)
across=1;

 /* Produce the donut chart. SUBGROUP= divides the donut into rings.
 Each ring represents a value of the subgroup variable, DEPT.
 The DONUTPCT= option controls the size of the donut
hole, which contains the text specified by LABEL=. The NOHEADING
option suppresses the default heading that contains the name of
the chart variable and the type of statistic.LEGEND= assigns
the LEGEND1 statement to the chart. */

proc gchart data=totals;
format sales dollar8.;
donut site / sumvar=sales
subgroup=dept
donutpct=30
label=('All' justify=center 'Quarters')
noheading
legend=legend1;
run;
quit;
