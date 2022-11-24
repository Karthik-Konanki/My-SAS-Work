 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHBRGRP                                    |
   |   TITLE: GCHBRGRP-Subgrouping a 3D Vertical Bar Chart|
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART AXIS PATTERN LEGEND         |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF       UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment. Set the background color to white */
goptions reset=all cback=white;

/* Create data set TOTALS. TOTALS contains quarterly sales data for
three manufacturing sites for one year. Sales figures are broken down
by department. */
data totals;
length dept $ 7 site $ 8;
input dept site quarter sales;
datalines;
Parts Sydney 1 7043.97
Parts Atlanta 1 8225.26
Tools Paris 4 1775.74
Tools Atlanta 4 3424.19
Repairs Sydney 2 5543.97
Repairs Paris 3 6914.25
;
/* run; */

/* Define the title */
title1 "Total Sales by Site";

/* Modify the midpoint axis. LABEL= suppresses the axis label. */
axis1 label=none offset=(10,8);

/* Modify the response axis. ORDER= specifies the major tick values for
the response axis. OFFSET= moves the top tick mark to the end of
the axis line. */
axis2 label=none order=(0 to 20000 by 5000) minor=none offset=(,0);

/* Modify the legend. LABEL= suppresses the legend label. SHAPE= defines
the size of the legend values.  CBORDER= draws a black frame around the
legend. */
legend1 label=none shape=bar(.15in,.15in) cborder=black;

/* Produce the vertical bar chart. SUBGROUP= creates a separate bar
segment for each department. INSIDE= prints the subgroup percent
statistic inside each bar segment.
OUTSIDE= prints the sum statistic above each bar. WIDTH= makes the
bars wide enough to display the statistics. SPACE= controls the space
between the bars. MAXIS= assigns the AXIS1 statement to the midpoint axis.
RAXIS= assigns the AXIS2 statement to the response axis.
LEGEND= assigns the LEGEND1 statement to the subgroup legend. CFRAME=
specifies the color for the 3D planes. */
proc gchart data=totals;
format sales dollar8.;
vbar3d site / sumvar=sales subgroup=dept inside=subpct
     outside=sum
     width=9
     space=7
     maxis=axis1
     raxis=axis2
     cframe=white
     autoref cref=gray
     legend=legend1;
run;
quit;
