 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GSYCMBP1                                            |
   |   TITLE: GSYCMBP1-Creating and Modifying Box Plots           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS SYMBOL GPLOT                         |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07         |
   | UPDATE CODE to Match Doc Code        UPDATE: MAY 2020       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */


goptions reset=all  border;

   /* create the data set GRADES */
data grades;
     input section $ grade @@;
     datalines;
A 74 A 89 A 91 A 76 A 87 A 93 A 93 A 96 A 55
B 72 B 72 B 84 B 81 B 97 B 78 B 88 B 90 B 74
C 62 C 74 C 71 C 87 C 68 C 78 C 80 C 85 C 82
;

   /* define title and footnote */
title1 "Comparison: Grades by Section";
footnote1 j=r  "GSYCMBP1(a) ";

   /* define symbol characteristics */
symbol interpol=boxt20 /* box plot              */
       co=blue         /* box and whisker color */
       bwidth=4        /* box width             */
       value=square    /* plot symbol           */
       cv=red          /* plot symbol color     */
       height=2;       /* symbol height         */

   /* define axis characteristics */
axis1 label=none
      value=(t=1 "Monday" j=c "section"
             t=2 "Wednesday" j=c "section"
             t=3 "Friday" j=c "section")
      offset=(5,5)
      length=50;

   /* generate plot */
proc gplot data= grades;
   plot grade*section / haxis=axis1
                        vaxis=50 to 100 by 10;
run;

      /* define footnote for second plot */
   footnote j=r "GSYCMBP1(b) ";

      /* define symbol for second plot */
   symbol interpol=boxt10 width=2;

   plot grade*section / haxis=axis1
                        vaxis=50 to 100 by 10;
run;
quit;
