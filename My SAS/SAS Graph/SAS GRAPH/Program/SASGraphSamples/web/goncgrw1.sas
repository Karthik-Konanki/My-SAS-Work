 /*+--------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                 |
   |                                                              |
   |    NAME: GONCGRW1                                            |
   |   TITLE: GONCGRW1-Combining Graphs and Reports in a Web Page |
   | PRODUCT: GRAPH                                               |
   |  SYSTEM: ALL                                                 |
   |    KEYS: GRAPHICS AXIS PATTERN GCHART                        |
   |   PROCS: SORT GCHART                                         |
   |    DATA: INTERNAL                                            |
   |                                                              |
   | SUPPORT: GRAPHICS STAFF               UPDATE: MAR 2015       |
   | UPDATE:  updated to run in SAS Studio UPDATE: 13MAY2020      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                           |
   |    MISC: EDIT THE FILENAME ON THE FILENAME STATEMENT.        |
   |                                                              |
   +--------------------------------------------------------------+*/

/* fileref for the output */
filename odsout "file-path";

/* close the currently open ODS destinations */
ods _all_ close;

/* set the graphics environment */
goptions reset=all border;

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


/* define the destination for the ODS graphics output and the
   PROC PRINT output */
/* assign a frame file and a contents file */
/* assign a body file for the first bar chart */
ods html5 path=odsout frame="sales_frame.html"
    contents="sales_contents.html"
    body="sales_body.html"
    anchor="body"
    nogtitle
    options(bitmap_mode="inline");

/********************* first bar chart and report **************/

/* define title and footnote for vertical bar chart */
title1 "Total Sales By Quarter";
footnote1 j=r "salesqtr ";

/* define axis characteristics */
axis1 order=(0 to 60000 by 20000)
      minor=(number=1)
      label=none;
axis2 label=none length=70pct value=("1Q" "2Q" "3Q" "4Q");

legend1 label=none shape=bar(4,4);

/* generate vertical bar chart of quarterly sales */
proc gchart data=totals;
   format sales dollar8.;
   vbar3d quarter / discrete
                    sumvar=sales
                    shape=cylinder
                    subgroup=site
                    cframe=grayaa
                    caxis=black
                    width=12
                    space=4
                    legend=legend1
                    maxis=axis2
                    raxis=axis1
                    des="Total Quarterly Sales"
                    name="salesqtr";
run;
quit;

/* sort the data set */
proc sort data=totals out=qtrsort;
   by quarter site;
run;

footnote1;
options nobyline;

/* generate a report of quarterly sales */
title1 "Sales for Quarter #byval(quarter)";
proc report data=qtrsort nowindows;
  by quarter;
  column quarter site dept sales;
  define quarter / noprint group;
  define site    / display group;
  define dept    / display group;
  define sales   / display sum format=dollar8.;
  compute after quarter;
          site="Total";
  endcomp;
  break after site    / summarize style=rowheader;
  break after quarter / summarize style=rowheader;
run;

/********************* second bar chart and report **************/

/* define title and footnote for vertical bar chart */
title1 "Total Sales By Department";
footnote1 j=r "salesdep ";

axis1 label=none
      minor=(number=1)
      order=(0 to 100000 by 20000);
axis2 label=none length=70pct;

/* generate vertical bar chart of departmental sales */
proc gchart data=totals;
   format sales dollar8.;
   vbar3d dept / shape=cylinder
                 subgroup=site
                 cframe=grayaa
                 width=12
                 space=4
                 sumvar=sales
                 legend=legend1
                 maxis=axis2
                 raxis=axis1
                 caxis=black
                 des="Total Department Sales"
                 name="salesdep";
run;
quit; 

/* sort the data set */
proc sort data=totals out=deptsort;
   by dept site;
run;

footnote1;

title1 "Sales for #byval(dept)";
proc report data=deptsort nowindows;
  by dept;
  column dept site quarter sales;
  define dept    / noprint group;
  define site    / display group;
  define quarter / display group;
  define sales   / display sum format=dollar8.;
  compute after dept;
          site="Total";
  endcomp;
  break after site / summarize style=rowheader;
  break after dept / summarize style=rowheader;
run;

ods html5 gtitle;

/********************* pie charts **************/

/* sort data set TOTALS in order by site */
proc sort data=totals out=sitesort;
     by site;
run;

/* define title and footnote for the pie charts */
title1 "Departmental Sales for #byval(site)";
footnote1 j=r "salespie ";

/* generate pie charts for each site */
proc gchart data=sitesort;
     format sales dollar8.;
     by site;
     pie3d dept /   noheading
                    coutline=black
                    sumvar=sales
                    des="Department Sales"
                    name="salespie";
run;
quit;
/* Close the ODS HTML5 destination */
ods html5 close;

