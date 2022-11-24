 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHBKGRP                                    |
   |   TITLE: GCHBKGRP-Subgrouping a Block Chart          |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART AXIS PATTERN LEGEND         |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF       UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/

goptions reset=all border;

/* Create data set TOTALS. TOTALS contains quarterly sales data for
two of the three manufacturing sites for one year. Sales figures are broken
down by department. */

data totals;
length dept $ 7 site $ 8;
input dept site quarter sales;
datalines;

Parts Sydney 1 3043.97
Parts Sydney 3 5142.63
Parts Atlanta 1 5225.26
Parts Atlanta 2 3529.06
Tools Sydney 4 1775.74
Tools Atlanta 4 3424.19
Repairs Sydney 2 5543.97
Repairs Atlanta 1 3788.93
Repairs Atlanta 2 4492.89
Repairs Atlanta 3 3914.25
;

/* Define title. */

title 'Average Sales by Department';
/* footnote j=r 'GCHBKGRP '; */

/* Define legend characteristics. LABEL= assigns new text to the legend label.
CBORDER= draws a black frame around the legend. */

legend1 cborder=black
label=('Quarter:')
position=(bottom right outside)
mode=protect
across=1;

/* Produce the block chart. The LABEL statement suppresses the midpoint and
group labels by assigning a null hexadecimal string to each variable name. */

proc gchart data=totals;
format quarter roman.;
format sales dollar8.;
label site='00'x dept='00'x;

/* TYPE= specifies the chart statistic as the mean value of the summary
variable SALES for each site. MIDPOINTS= selects the two sites and the
order in which they appear.
GROUP= creates a separate row of blocks for each different value of
DEPT. SUBGROUP= divides each block into separate segments for the four
quarters. LEGEND= assigns the LEGEND1 statement to the
graph. NOHEADING suppresses the default heading that would otherwise
appear above the
chart. */

block site / sumvar=sales
type=mean
midpoints='Sydney' 'Atlanta'
group=dept
subgroup=quarter
legend=legend1
noheading;
run;
quit;
