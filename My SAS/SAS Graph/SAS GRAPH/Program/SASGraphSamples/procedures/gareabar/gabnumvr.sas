/*+------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: GABNUMVR                                               |
   |   TITLE: GABNUMVR-Area Bar Chart with a Numeric Chart Variable  |
   | PRODUCT: GRAPH                                                  |
   |  SYSTEM: ALL                                                    |
   |    KEYS: GRAPHICS ODS GAREABAR                                  |
   |   PROCS: GAREABAR                                               |
   |    DATA: TOTALS                                                 |
   |                                                                 |
   | SUPPORT: GRAPHICS STAFF         UPDATE: 27MAR2015               | 
   | SUPPORT: RECODED FOR SAS STUDIO UPDATE: 11MAY2020               |
   |     REF: SAS/GRAPH REFERENCE GUIDE                              |
   +-----------------------------------------------------------------+*/

/* Create a file reference for the ODS output.                        */
filename odsout "file-path";

/*   Create the data set.                                             */
data totals;
 input Site $ Quarter Sales Salespersons;
 format Sales dollar12.2;
datalines;
Lima    1 4043.97    4
NY      1 8225.26   12
Rome    1 3543.97    6
Lima    2 3723.44    5
NY      2 8595.07   18
Rome    2 5558.29   10
Lima    3 4437.96    8
NY      3 9847.91   24
Rome    3 6789.85   14
Lima    4 6065.57   10
NY      4 11388.51  26
Rome    4 8509.08   16
;

/* Close the currently open ODS destinations.                         */
ods _all_ close;

/*   Set graphic options.                                             */
goptions reset=all device=activex;

/* Open ODS HTML                                                      */
ods html path=odsout file="areabarchartnum.html";

/*   The vbar variable QUARTER specifies the vbar categories.         */
/*   The SALESPERSONS variable specifies the width of each bar.       */
/*   The SUMVAR=SALES option specifies the height of each bar.        */
/*   The WSTAT=PCT option specifies percent for the width             */
/*   of each bar                                                      */
proc gareabar data=totals;
   vbar quarter*salespersons /
      sumvar=sales
      wstat=pct;
run;
quit;

/* Reset ODS destination */
ods html close;

/* Reset graphics environment */
goptions reset=all;

/* Reset the file reference */
filename odsout clear;

