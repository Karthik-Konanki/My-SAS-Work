 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLBUBL2                                           |
   |   TITLE: GPLBUBL2-Labeling and Sizing Plot Bubbles           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GPLOT AXIS FORMAT                |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07         |
   | SUPPORT: removed footnote            UPDATE: MAY2020        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS IS A BUBBLE PLOT.                             |
   +-------------------------------------------------------------+*/
   /* set the graphics environment */
goptions reset=all border;

   /* create the data set JOBS */
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
   /* define titles */

title1 "Member Profile";
title2 "Salaries and Number of Member Engineers";


axis1 label=none
offset=(5,5);
axis2 order=(0 to 40000 by 10000)
label=none;

 proc gplot data=jobs;
  format dollars dollar9. num comma7.0;
  bubble dollars*eng=num / haxis=axis1
                            vaxis=axis2
                            vminor=1
                            bcolor=darkred
                            blabel
                            bsize=3;
run;
quit;
