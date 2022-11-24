 /*+--------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                 |
   |                                                              |
   |    NAME: GPLDRIL1                                            |
   |   TITLE: GPLDRIL1-Creating a Plot with Drill-down for the Web|
   | PRODUCT: GRAPH                                               |
   |  SYSTEM: ALL                                                 |
   |    KEYS: GRAPHICS GOPTIONS GPLOT SYMBOL                      |
   |   PROCS: GPLOT                                               |
   |    DATA: INTERNAL                                            |
   |                                                              |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 07MAY2015       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                           |
   | UPDATES: Removed Quit; statement from REPORT and SORT procs  |
   | SUPPORT: updated to run in SAS Studio UPDATE: MAY2020        |
   |    MISC:                                                     |
   |                                                              |
   |          FOR CMS, CHANGE FILENAME SPECIFICATIONS FOR         |
   |          ODS STATEMENTS                                      |
   |                                                              |
   |          USE city_plots.html TO SEE THE RESULTS IN YOUR      |
   |          BROWSER                                             |
   +--------------------------------------------------------------+*/

/* Define a fileref for the output. */
filename odsout "file-path";

/* Set the graphics environment. */
goptions reset=all border device=gif;

/* Close the currently open ODS destinations */
ods _all_ close;

/* Open an HTML output file in ODS. */
ods html path=odsout /* gpath=odsout */
         body="city_plots.html"
         nogtitle;

/* Create the data set CITYTEMP. */
data citytemp;
   input  Month Fahrenheit City $ @@;
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


/* Add the link variable to the data set. */
data newtemp;
   set citytemp;
   length citydrill $ 40;
      if city="Minn" then
      citydrill="HREF='city_reports.html#IDX1'";
   else if city="Phoenix" then
      citydrill="HREF='city_reports.html#IDX2'";
   else if city="Raleigh" then
      citydrill="HREF='city_reports.html#IDX3'";

/* Define titles and footnotes. */
title1 "Average Monthly Temperature";
footnote1 j=l " Click a data point or legend symbol";

/* Define a symbol. */
symbol1 interpol=join
        value=dot;

/* Generate a plot of three variables  */
/* that produces a legend.             */
proc gplot data=newtemp;
   plot fahrenheit*month=city / hminor=0
        html=citydrill
        html_legend=citydrill;
run;
quit;

/* Open the PROC REPORT output file. */
ods html path=odsout
body="city_reports.html";

/* Sort data set NEWTEMP in order by city. */
proc sort data=newtemp;
   by city month;
run;

/* Clear the footnotes and suppress the default BY-line. */
goptions reset=footnote;
option nobyline;

/* Print a report of monthly temperatures */
/* for each city.                         */
title1 "Monthly Temperatures in #byval(city)";
proc report data=newtemp nowindows;
  by city;
  column city month fahrenheit;
  define city       / noprint group;
  define month      / group;
  define Fahrenheit / group;
run;

/* Close ODS HTML and open a destination for subsequent programs */
ods html close;
/* Clear the filename reference */
filename odsout clear;
