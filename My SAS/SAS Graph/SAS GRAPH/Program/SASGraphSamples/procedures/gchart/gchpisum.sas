 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHPISUM                                    |
   |   TITLE: GCHPISUM-Sum Statistic for a Pie Chart      |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART                             |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/


goptions reset=all border;

 /* Create data set TOTALS.
    TOTALS contains quarterly sales data for three
    manufacturing sites for one year. Sales figures
    are broken down  by department.*/
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
/* footnote j=r 'GCHPISUM(a)'; */

 /* Produce the first pie chart. The pie statement produces a
 two dimensional pie chart.    Sumvar= calculates the sum of
 SALES for each value of the chart variable SITE. The default
 statistic for SUMVAR= is SUM.  The summary variable SALES
 is assigned a dollar format. The embedded RUN statement is
 required to end this first RUN-Group and honor the action
 statement and other SAS statements. It signals that the
 procedure will remain active.*/

proc gchart data=totals;
format sales dollar8.;
pie site / sumvar=sales;
run;

 /* Define footnote for second pie chart. */

 /* footnote j=r 'GCHPISUM(b)'; */

 /* Produce the second pie chart.  The PIE3D statement produces
 a three dimensional pie chart.    EXPLODE= separates the slice
 for PARIS from the rest of the pie. */

pie3d site / sumvar=sales
explode="Paris";
run;
quit;
