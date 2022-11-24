 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GKPSPD                                      |
   |   TITLE: GKPSPD-Defining a Speedometer               |
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

goptions reset=all device=javaimg xpixels=210 ypixels=200;

 /* Generate the KPI chart. Specify the segment boundaries,
    actual KPI value, and target value. The LFONT= option
    specifies the font for the label. The FORMAT= option
    specifies the SAS format for the values in the chart. */

proc gkpi mode=raised;
   speedometer actual=.72 bounds=(0 .40 .60 1) / target=.85
   lfont=(f="Albany AMT" height=.5cm) label="Average Capacity"
   format="percent8.0";
run;

 /* The GKPI procedure supports RUN-group processing, so it is
    recommended that you enter the QUIT statement to end the
    procedure.*/

quit;

 /* Reset the graphics environment and the file reference.  */

ods html5 close;
goptions reset=all;
filename odsout clear;