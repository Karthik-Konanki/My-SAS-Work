/*+------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: GABWSTAT                                               |
   |   TITLE: GABWSTAT-Generating an Area Bar Chart                  |
   |          with with Subgroups;                                   |
   |          Using the RSTAT= option and the WSTAT= option          |
   |          to Calculate                                           |
   |          Statistics as Percentages                              |
   | PRODUCT: GRAPH                                                  |
   |  SYSTEM: ALL                                                    |
   |    KEYS: GRAPHICS ODS GAREABAR                                  |
   |   PROCS: GAREABAR                                               |
   |    DATA: TOTALS                                                 |
   |                                                                 |
   | SUPPORT: GRAPHICS STAFF         UPDATE: 27MAR2015               |
   |          Recoded for SAS Studio UPDATE: 11MAY2020               |
   |     REF: SAS/GRAPH REFERENCE GUIDE                              |
   +-----------------------------------------------------------------+*/

/* Create a file reference for the ODS output.                        */
filename odsout "file-path";

/*   Create the data set.                                             */
data totals;
 input Site Quarter Sales Salespersons;
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

/* Close the currently open ODS destinations.                          */
ods _all_ close;

/*   Set graphic options.                                              */
goptions reset=all device=activex;

/* Open ODS HTML                                                       */
ods html path=odsout file="areabarchartwstat.html";

/*   The hbar variable SITE specifies the hbar categories.             */
/*   The SALESPERSONS variable specifies the width of each bar.        */
/*   The SUMVAR=SALES option specifies the length of each bar.         */
/*   The SUBGROUP=QUARTER option specifies the subgroup variable       */
/*   for each bar.                                                     */
/*   The RSTAT=PCT option specifies percent for the length of each bar.*/
/*   The WSTAT=PCT option specifies percent for the width of each bar. */
proc gareabar data=totals;
   hbar site*salespersons /
      sumvar=sales
      subgroup=quarter
      rstat=pct
      wstat=pct;
run;
quit;

/* Reset ODS destination */
ods html close;

/* Reset graphics environment */
goptions reset=all;

/* Reset the file reference */
filename odsout clear;