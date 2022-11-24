 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GCHBRSUM                                           |
   |   TITLE: GCHBRSUM-Sum Statistic in Bar Charts               |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GCHART                                    |
   |   PROCS: GCHART                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/
goptions reset=all border;
/* hsize=5.5in vsize=4.12in border horigin=1in vorigin=1in; */


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


/*  Define the title for charts. */

title1 "Total Sales";
/* footnote1 j=r "GCHBRSUM(a)"; */


/* Produce the horizontal bar chart. The HBAR statement produces a
two-dimensional bar chart. SUMVAR= calculates the sum of SALES for
each value of the chart variable SITE. The default statistic for
SUMVAR= is SUM. The summary variable SALES is assigned a dollar
format. The embedded RUN statement is required to end this first
RUN-Group and honor the action statement and other SAS statements.
It signals that the procedure will remain active.*/

proc gchart data=totals;
format sales dollar8.;
hbar site / sumvar=sales;
run;


/* Produce the vertical bar chart. Because the procedure supports
RUN-group processing, you do not have to repeat the PROC GCHART
statement to generate the second chart. The VBAR3D statement
produces a three-dimensional vertical bar chart.
/* The FOOTNOTE1 statement replaces the previous footnote. */

vbar3d site / sumvar=sales;
/* footnote1 j=r "GCHBRSUM(b)"; */
run;
quit;
