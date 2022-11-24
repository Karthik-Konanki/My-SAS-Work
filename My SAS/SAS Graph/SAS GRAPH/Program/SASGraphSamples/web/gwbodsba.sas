 /*+-----------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y         |
  |                                                      |
  |    NAME: GWBODSBA                                    |
  |   TITLE: GWBODSBA-Generating a Web table of contents |
  | PRODUCT: GRAPH                                       |
  |  SYSTEM: ALL                                         |
  |    KEYS: GRAPHICS GCHART ODS WEB GIF                 |
  |   PROCS: GCHART                                      |
  |    DATA: INTERNAL                                    |
  |                                                      |
  | SUPPORT: GRAPHICS STAFF        UPDATE: 20APR2020     |
  |     REF: SAS/GRAPH REFERENCE GUIDE                   |
  |    MISC: EDIT AND UNCOMMENT THE FILENAME STATEMENT.  |
  +------------------------------------------------------+*/

/**  This program uses ODS to create HTML and    **/
/**  and GIF output.                             **/

filename odsout "file-path";

/* Close the currently open ODS destinations.    */
ods _all_ close;

/* Set the graphics environment. */
goptions reset=global gunit=pct
         htitle=6 htext=4 ctext=black
         ftitle=zapfb ftext=swiss;

/* Create the data set REGSALES. */
data regsales;
    length Region State $ 8;
    format Sales dollar8.;
    input Region State Sales;
    datalines;
West CA 13636
West OR 18988
West WA 14523
Central IL 18038
Central IN 13611
Central OH 11084
Central MI 19660
South FL 14541
South GA 19022
;

/* Sort the data using the BY variable. */
proc sort data=regsales;
by region;
run;

/* Assign graphics options for ODS output. */
goptions device=gif transparency noborder;

/* Open the HTML destination for ODS output. */
ods html file='sales.html'
         contents='saleCont.html'
         frame='saleFram.html'
         path=odsout
         newfile=output;

/* Run the GCHART procedure. */
title1 'Regional Sales';
proc gchart data=regsales;
   vbar3d state / sumvar=sales
   patternid=by;
by region;
run;
quit;

/* Close the ODS HTML destination. */
ods html close;
