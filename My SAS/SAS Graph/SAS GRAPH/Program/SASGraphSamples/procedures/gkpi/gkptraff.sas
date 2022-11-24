 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GKPTRAFF                                    |
   |   TITLE: GKPTRAFF-Creating a Traffic Light           |
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

goptions reset=all device=javaimg xpixels=120 ypixels=210;

 /* Generate the KPI chart. Specify the segment boundaries,
    actual KPI value, and colors.  The NOAVALUE option turns
    off the display of the actual KPI value. The colors are
    specified as SAS Registry Color names. */

proc gkpi mode=raised;
   trafficlight actual=598 bounds=(1500 900 600 0) /
   colors=(green yellow red) noavalue
   label="New Subscriptions";
run;

 /* The GKPI procedure supports RUN-group processing, so it is
    recommended that you enter the QUIT statement to end the
    procedure. */

quit;

 /* Reset the graphics environment and the file reference.  */

ods html5 close;
goptions reset=all;
filename odsout clear;
