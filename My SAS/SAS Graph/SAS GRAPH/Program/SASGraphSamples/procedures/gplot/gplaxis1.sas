 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLAXIS1                                           |
   |   TITLE: GPLAXIS1-Adding a Right Vertical Axis to a Plot    |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GPLOT AXIS                       |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 05MAR2013      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS IS A BUBBLE PLOT.                             |
   |    DESC: REMOVED FOOTNOTE and ADDED LABEL=NONE to AXIS stmt.|
   +-------------------------------------------------------------+*/


   /* Set the graphics environment */
goptions reset=all border;

   /* Create the data set JOBS */
data jobs;
   length eng $5;
   input eng dollars num;
   datalines;
Civil 27308 73273
Aero  29844 70192
Elec  22920 89382
Mech  32816 19601
Chem  28116 25541
Petro 18444 34833
;
   /* Create the data set JOBS2 */
   /* Calculate variable YEN    */
data jobs2;
   set jobs;
   yen=dollars*125;
run;

   /*Define the titles */
title1 "Member Profile";
title2 "Salaries and Number of Member Engineers";

   /* Define the horizontal-axis characteristics */
axis1 label=none
      offset=(5,5);

   /* Generate a bubble plot with a second vertical axis */
proc gplot data= jobs2;
   format dollars dollar7. num yen comma9.0;
   bubble dollars*eng=num / haxis=axis1
                            vaxis=10000 to 40000 by 10000
                            hminor=0
                            vminor=1
                            blabel;
   bubble2 yen*eng=num / vaxis=1250000 to 5000000 by 1250000
                         vminor=1;
run;
quit;
