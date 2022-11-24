 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHSTSUM                                    |
   |   TITLE: GCHSTSUM-Sum Statistic in a Star Chart      |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART                             |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/


/* Set the graphics environment.
   Generate a border around graph.*/

goptions reset=all border;


/* Create data set TOTALS. TOTALS contains quarterly sales data for
three manufacturing sites for one year. Sales figures are broken down
by department. */

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


/* Define title. */

title 'Total Sales';
/* footnote j=r 'GCHSTSUM '; */


/* Produce the star chart. SUMVAR= calculates the sum of SALES for
each value of the chart variable SITE. Because the TYPE= option is
omitted, the default statistic is sum. The FORMAT
statement assigns a format to the summary variable SALES. */

proc gchart data=totals;
format sales dollar8.;
star site / sumvar=sales;
run;
quit;
