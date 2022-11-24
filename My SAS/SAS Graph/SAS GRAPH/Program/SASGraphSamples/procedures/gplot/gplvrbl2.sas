  /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLVRBL2                                           |
   |   TITLE: GPLVRBL2-Plotting Three Variables                  |
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

/* Set the graphics environment. */
goptions reset=all border;

/* Create a format for the month numbers that displays the months
   as three-character month names */
proc format;
   value mmm_fmt
   1='Jan'
   2='Feb'
   3='Mar'
   4='Apr'
   5='May'
   6='Jun'
   7='Jul'
   8='Aug'
   9='Sep'
   10='Oct'
   11='Nov'
   12='Dec'
   ;
run;

/* Create the data set CITYTEMP. */
data citytemp;
   input  month faren city $ @@;
   datalines;
   1      40.5    Raleigh     1      12.2    Minn
   1      52.1    Phoenix     2      42.2    Raleigh
   2      16.5    Minn        2      55.1    Phoenix
   3      49.2    Raleigh     3      28.3    Minn
   3      59.7    Phoenix     4      59.5    Raleigh
   4      45.1    Minn        4      67.7    Phoenix
   5      67.4    Raleigh     5      57.1    Minn
   5      76.3    Phoenix     6      74.4    Raleigh
   6      66.9    Minn        6      84.6    Phoenix
   7      77.5    Raleigh     7      71.9    Minn
   7      91.2    Phoenix     8      76.5    Raleigh
   8      70.2    Minn        8      89.1    Phoenix
   9      70.6    Raleigh     9      60.0    Minn
   9      83.8    Phoenix    10      60.2    Raleigh
  10      50.0    Minn       10      72.2    Phoenix
  11      50.0    Raleigh    11      32.4    Minn
  11      59.8    Phoenix    12      41.2    Raleigh
  12      18.6    Minn       12      52.5    Phoenix
;
run;

/* Define the title and footnotes for the plot. */
title1 "Average Monthly Temperature";
footnote1 j=l " Source: 1984 American Express";
footnote2 j=l "         Appointment Book";

/* Define the symbol for the first plot. */
symbol1 interpol=join value=dot;

/* Generate a plot of three variables */
/* that produces a legend.            */
proc gplot data= citytemp;
   plot faren*month=city / hminor=0;
run;

/* Generate second plot with modified axes. */

/* Define the symbols. */
symbol1 interpol=spline width=2 value=triangle c=steelblue;
symbol2 interpol=spline width=2 value=circle c=indigo;
symbol3 interpol=spline width=2 value=square c=orchid;

/* Define the axis. */
axis1 label=none
      order = 1 to 12 by 1
      offset=(2);

axis2 label=("Degrees" justify=right  "Fahrenheit")
      order=(0 to 100 by 10);

/* Enhance the legend. */
legend1 label=none value=(tick=1 "Minneapolis");

/* Format the month numbers into three-character month names */
format month mmm_fmt.;

/* Generate second plot */
plot faren*month=city /
        haxis=axis1 hminor=0
        vaxis=axis2 vminor=1
        legend=legend1;

run;
quit;
