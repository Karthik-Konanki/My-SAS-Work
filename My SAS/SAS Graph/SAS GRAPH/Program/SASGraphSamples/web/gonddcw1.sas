 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GONDDCW1                                           |
   |   TITLE: GONDDCW1-Creating a Drill-down Chart for the Web   |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS PATTERN GCHART                       |
   |   PROCS: SORT GCHART                                        |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: MAR 2015       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: EDIT THE FILE-PATH ON THE FILENAME STATEMENT.      |
   |                                                             |
   |                                                             |
   |          USE report_body.html TO SEE THE RESULTS IN YOUR    |
   |          BROWSER                                            |
   | UPDATE: 19OCT2016 changed cframe to ltgray                  |
   | UPDATE: 13MAY2020 updated to run in SAS Studio              |
   +-------------------------------------------------------------+*/

/* fileref for the output */
filename odsout "file-path";

/* close the currently open ODS destinations */
ods _all_ close;

/* set the graphics environment */
goptions reset=all device=gif transparency noborder;

/* create data set TOTALS */
data totals;
   length Dept $ 7 Site $ 8;
   input Dept Site Quarter Sales;
   datalines;

Repairs Sydney  1 5592.82
Repairs Atlanta 1 9210.21
Tools   Sydney  1 1775.74
Tools   Atlanta 1 2424.19
Tools   Paris   1 5914.25
Parts   Atlanta 2 11595.07
Parts   Paris   2 9558.29
Repairs Sydney  2 5505.31
Repairs Paris   2 7538.56
Tools   Atlanta 2 1903.99
Tools   Paris   2 7868.34
Parts   Sydney  3 8437.96
Parts   Paris   3 6789.85
Tools   Atlanta 3 3048.52
Tools   Paris   3 9017.96
Parts   Sydney  4 6065.57
Parts   Atlanta 4 9388.51
Parts   Paris   4 8509.08
Repairs Atlanta 4 2088.30
Repairs Paris   4 5530.37
;

/* add the HTML variable to TOTALS.DATA.SAS  */
data newtotal;
   set totals;
   length sitedrill $40;
if site="Atlanta" then
   sitedrill="HREF='report_deptsales.html#IDX'";

else if site="Paris" then
   sitedrill="HREF='report_deptsales.html#IDX1'";

if site="Sydney" then
   sitedrill="HREF='report_deptsales.html#IDX2'";
run;

/* assign the destination for the ODS graphics output */
/* and specify the path and filename                  */
ods html5 path=odsout body="report_body.html"
   nogtitle
   options(bitmap_mode="inline");

/* define title and footnote for chart */
title1 "Total Sales for All Sites";
footnote1 j=l "click on bars" j=r "REPORT3D ";

/* assign a pattern color for all bars */
pattern color=cyan;

/* define axis characteristics */
axis1 order=(0 to 80000 by 20000)
      minor=(number=1)
      label=none;
axis2 label=none offset=(9,9);

/* generate vertical bar chart */
proc gchart data=newtotal;
   format sales dollar8.;
   vbar3d site / discrete
                 width=15
                 sumvar=sales
                 inside=sum
                 html=sitedrill
                 coutline=black
                 cframe=ltgray
                 maxis=axis2
                 raxis=axis1
                 name="report3d ";
run;
quit;

/* Close the ODS HTML5 destination */
ods html5 close;

/* sort data set NEWTOTAL in order of the BY variable */
proc sort data=newtotal;
   by site dept quarter;
run;

/* open the file for the PROC REPORT output */
/* closing report_body.html */
ods html body="report_deptsales.html" ;

/* clear the footnote */
goptions reset=footnote;

/* suppress the default BY-line */
/* define a title that includes the BY-value */
options nobyline;
title1 "Sales Report for #byval(site)";

/* print a report of departmental sales for each site */
proc report data=newtotal nowindows;
  by site;
  column site dept quarter sales;
  define site    / noprint group;
  define dept    / display group;
  define quarter / display group;
  define sales   / display sum format=dollar8.;
  compute after site;
          dept="Total";
  endcomp;
  break after site / summarize style=rowheader page;
run;

ods html close;
file odsout clear;
