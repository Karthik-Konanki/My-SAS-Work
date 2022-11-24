 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GKPDIAL                                     |
   |   TITLE: GKPDIAL-Creating a Dial KPI Chart           |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GKPI DASHBOARD                     |
   |   PROCS: GKPI                                        |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 28FEB11       |
   | recoded to run in SAS Studio   UPDATE: 15MAY2020     |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

  /* Set the graphics environment. The GKPI procedure
    supports the JAVAIMG device only. In SAS Studio SAS 
    Viya 4 this means you must use ods html5 destination  */

filename odsout "file-path";
ods _all_ close;
ods html5 gpath=odsout;

goptions reset=all device=javaimg xpixels=240 ypixels=200;

 /* Generate the KPI chart. Specify the segment boundaries,
    actual KPI value, and target value. In this case, the
    target value falls on a segment boundary. The NOLOWBOUNDARY
    option specifies that the KPI chart behaves as if the actual
    KPI value falls in the higher range segment. The AFONT= and
    BFONT= options specify the fonts for the actual value and the
    boundary segment values, respectively. The FORMAT= option
    specifies the SAS format for the values in the chart. */

proc gkpi mode=raised;
dial actual=.46 bounds=(0 .23 .46 .65 .79 1) /
   target=.9  nolowbound  format="percent8.0"
   afont=(f="Albany AMT" height=.5cm)
   bfont=(f="Albany AMT" height=.4cm) ;
run;

 /* The GKPI procedure supports RUN-group processing, so it is
    recommended that you enter the QUIT statement to end the
    procedure.*/

quit;

 /* Reset the graphics environment and the file reference.  */

ods html5 close;
goptions reset=all;
filename odsout clear;

