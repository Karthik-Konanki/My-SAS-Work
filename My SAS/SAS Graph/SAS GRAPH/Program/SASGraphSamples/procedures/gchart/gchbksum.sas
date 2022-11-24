 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHBKSUM                                    |
   |   TITLE: GCHBKSUM-Sum Statistic in a Block Chart     |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART PATTERN LEGEND              |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/

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

title "Total Sales";
/*footnote j=r "GCHBKSUM";*/

/* Produce the block chart. The BLOCK statement produces a block chart.
SUMVAR= calculates the sum of SALES for each value of the chart variable
SITE.  With SUMVAR= the default statistic is SUM. The summary variable
SALES is assigned a dollar format. */

proc gchart data=totals;
format sales dollar8.;
block site / sumvar=sales;
run;
quit;
