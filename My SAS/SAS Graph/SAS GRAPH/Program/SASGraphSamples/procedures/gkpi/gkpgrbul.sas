 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GKPGRBUL                                    |
   |   TITLE: GKPGRBUL-Creating a Gray Scale Bullet Graph |
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

goptions reset=all device=javaimg xpixels=130 ypixels=250;

 /* Generate the KPI chart. Specify the segment boundaries,
    actual KPI value, target value, and colors. The gray
    scale colors are specified using hexadecimal RGB values. */

proc gkpi mode=raised;
vbullet
   actual=.58  bounds=(0 .22 .38 .52 .68 1) / target=.75
   colors=(cx747474 cx8C8C8C cxB2B2B2 cxD2D2D2 cxE6E6E6);
run;

 /* The GKPI procedure supports RUN-group processing, so it is
    recommended that you enter the QUIT statement to end the
    procedure. */

quit;

 /* Reset the graphics environment and the file reference.  */

ods html5 close;
goptions reset=all;
filename odsout clear;

