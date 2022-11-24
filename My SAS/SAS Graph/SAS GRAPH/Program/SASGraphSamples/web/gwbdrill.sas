 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GWBDRILL                                    |
   |   TITLE: GWBDRILL-ODS/GIF web graph with drill-down  |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS ODS GIF VBAR3D WEB                 |
   |   PROCS: VBAR3D                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 20APR2020     |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   |    MISC: EDIT AND UNCOMMENT THE FILENAME STATEMENT.  |
   +------------------------------------------------------+*/

/* Define a fileref for the ODS output. */
filename odsout "file-path";

/* Close the currently open ODS destinations. */
ods _all_ close;

/* Set graphic options. */
goptions reset=all border device=gif;

/* Create the data set REGSALES. */
data regsales;
   length Region State $ 8;
   format Sales dollar8.;
   input Region State Sales;

   /* Initialize the link variable. */
   length rpt $40;

   /* Assign values to the link variable. */
   if Region="Central" then
      rpt="central.html";
   else if Region="South" then
     rpt="south.html";
   else if Region="West" then
     rpt="west.html";

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

/* Open the HTML5 destination and specify the path and filename */
ods html5 path=odsout body="company.html" style=statistical
   options(bitmap_mode="inline");

 /* Create a chart that uses the link variable.  */
title1 "Company Sales";
proc gchart data=regsales;
   vbar region / sumvar=sales
   patternid=midpoint
   url=rpt; /* Set the URL variable to rpt */
run;
quit;

/* Close the ODS HTML5 destination */
ods html5 close;

 /* Create the Central sales page. */
ods html path=odsout body="central.html";
title1 "Central Sales";
proc print data=regsales noobs;
   var state sales;
   where region="Central";
run;
quit;
ods html close;

/* Create the Southern sales page. */
title1 "Southern Sales";
ods html path=odsout body="south.html";
proc print data=regsales noobs;
   var state sales;
   where region="South";
run;
quit;
ods html close;

/* Create the Western sales page. */
title1 "Western Sales";
ods html path=odsout body="west.html";
proc print data=regsales noobs;
   var state sales;
   where region="West";
run;
quit;
ods html close;
