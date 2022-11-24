 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLSCVL1                                           |
   |   TITLE: GPLSCVL1-Plotting with Different Scales of Values  |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GPLOT AXIS SYMBOL                |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: MAY 09         |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS PLOT USES INTERPOLATION.                      |
   +-------------------------------------------------------------+*/


/* set the graphics environment */
goptions reset=all border;

/* create a format for the month numbers that displays the months
   as three-character month names */
proc format;
   value mmm_fmt
   1='JAN'
   2='FEB'
   3='MAR'
   4='APR'
   5='MAY'
   6='JUN'
   7='JUL'
   8='AUG'
   9='SEP'
   10='OCT'
   11='NOV'
   12='DEC'
   ;
run;

/* create the data set MINNTEMP */
data minntemp;
   input @10 month
         @23 f2;    /* fahrenheit temperature for Minneapolis */

   /* calculate centigrade temperature */
   /* for Minneapolis                  */
   c2=(f2-32)/1.8;
   output;
   datalines;
01JAN83  1    1   40.5  12.2  52.1
01FEB83  2    1   42.2  16.5  55.1
01MAR83  3    2   49.2  28.3  59.7
01APR83  4    2   59.5  45.1  67.7
01MAY83  5    2   67.4  57.1  76.3
01JUN83  6    3   74.4  66.9  84.6
01JUL83  7    3   77.5  71.9  91.2
01AUG83  8    3   76.5  70.2  89.1
01SEP83  9    4   70.6  60.0  83.8
01OCT83  10   4   60.2  50.0  72.2
01NOV83  11   4   50.0  32.4  59.8
01DEC83  12   1   41.2  18.6  52.5
;

/* define title and footnotes */
title1 "Average Monthly Temp for Minneapolis";
footnote1 j=l " Source: 1984 American Express";
footnote2 j=l "         Appointment Book";

/* define symbol characteristics */
symbol1 interpol=needle ci=blue cv=red  value=star;
symbol2 interpol=none value=none;

/* define axis characteristics */
axis1 label=none
      order=(1 to 12 by 1)
      offset=(2);

axis2 label=( "Degrees" justify=right " Centigrade")
      order=(-20 to 30 by 10);

axis3 label=( "Degrees" justify=left "Fahrenheit")
      order=(-4 to 86 by 18);

/* generate a plot with a second vertical axis */
proc gplot data= minntemp;

   /* Format the month numbers into three-character month names */
   format month mmm_fmt.;

   /* Generate the plot */
   plot c2*month / haxis=axis1 hminor=0
                   vaxis=axis2 vminor=1;

   plot2 f2*month / vaxis=axis3 vminor=1;

run;
quit;
