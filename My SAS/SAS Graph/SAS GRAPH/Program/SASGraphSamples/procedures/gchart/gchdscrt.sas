 /*+-------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y          |
   |                                                       |
   |    NAME: GCHDSCRT                                     |
   |   TITLE: GCHDSCRT-Discrete Numeric Var in a Star Chart|
   | PRODUCT: GRAPH                                        |
   |  SYSTEM: ALL                                          |
   |    KEYS: GRAPHICS GCHART                              |
   |   PROCS: GCHART                                       |
   |    DATA: INTERNAL                                     |
   |                                                       |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                    |
   +-------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/

goptions reset=all border;



/* Create the data set REJECTS. REJECTS contains data on the
number of defective parts produced at each of three sites for
12 months. BADPARTS is the number of parts that were rejected
at each site for each month. */

data rejects;
informat date date9.;
input site $ date badparts;
datalines;
Sydney 01JAN1997 8
Sydney 01FEB1997 11
Sydney 28JUN1997 13
Sydney 31OCT1997 6
Paris 11APR1997 12
Paris 04MAY1997 12
Paris 30AUG1997 14
Paris 01DEC1997 7
Atlanta 15MAR1997 7
Atlanta 18JUL1997 12
Atlanta 03SEP1997 10
Atlanta 12NOV1997 9
;


/* Define title. */

title 'Rejected Parts';
/* footnote j=r 'GCHDSCRT(a) '; */


/* Produce the first star chart. DISCRETE must be specified
because the numeric chart variable, DATE is assigned the WORDDATE3.
Using FILL=S fills all the slices with solid
The embedded RUN statement is required to end this first
RUN-Group and honor the action statement and other SAS statements.
It signals that the procedure will remain active.patterns. */

proc gchart data=rejects;
format date worddate3.;
star date / discrete
sumvar=badparts
noheading
fill=s;
run;


/* Define footnote for the second chart. */
/* footnote j=r 'GCHDSCRT(b) '; */



/* Produce the second star chart with slices and a solid fill.
NOHEADING suppresses the default heading for the star chart.
NOCONNECT suppresses the lines that by default join the
ends of the spines.  */

star date / discrete
sumvar=badparts
noheading
noconnect;
run;
quit;
