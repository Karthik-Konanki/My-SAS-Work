 /*+---------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y            |
   |                                                         |
   |    NAME: GKPGRSLD                                       |
   |   TITLE: GKPGRSLD-Using Default Colors as Active Colors |
   | PRODUCT: GRAPH                                          |
   |  SYSTEM: ALL                                            |
   |    KEYS: GRAPHICS GKPI DASHBOARD                        |
   |   PROCS: GKPI                                           |
   |    DATA: INTERNAL                                       |
   |                                                         |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 28FEB1           |
   | recoded to run in SAS Studio   UPDATE: 15MAY2020        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                      |
   +---------------------------------------------------------+*/

 /* Set the graphics environment. The GKPI procedure
    supports the JAVAIMG device only. In SAS Studio SAS 
    Viya 4 this means you must use ods html5 destination  */

filename odsout "file-path";
ods _all_ close;
ods html5 gpath=odsout;
goptions reset=all device=javaimg xpixels=180 ypixels=110;

 /* Generate the KPI chart. Specify the segment boundaries,
    actual KPI value, and colors. Boundary values can be
    positive and/or negative, but must be specified in either
    ascending or descending order. All colors are specified
    as hexadecimal RGB values. The same value of gray, cxB2B2B2,
    is used as the inactive color for all segments. The default
    colors are used as the active colors. */

proc gkpi mode=raised;
hslider actual=-6.7 bounds=(-10 -5 0 5 10) /
   colors=(cxB2B2B2 cxB2B2B2 cxB2B2B2 cxB2B2B2)
   activecolors=(cxD06959 cxE1A05D cxBDCD5F cx84AF5B);
run;

 /* The GKPI procedure supports RUN-group processing, so it is
    recommended that you enter the QUIT statement to end the
    procedure. */

quit;

 /* Reset the graphics environment and the file reference.  */
ods html5 close;
goptions reset=all;
filename odsout clear;
