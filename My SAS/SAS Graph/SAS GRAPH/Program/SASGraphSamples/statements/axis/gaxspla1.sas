/*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GAXSPLA1                                           |
   |   TITLE: GAXSPLA1-Specifying Logarithmic Axes               |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS SYMBOL GPLOT                         |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 28FEB13        |
   | SUPPORT: Fix reversed comment        UPDATE: 12MAY20        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

/* Set the graphics environment. */
goptions reset=all gunit=pct;


/* Create the data set. */
data concentr;
   input pH conc;
   datalines;
1  1E-1
2  1E-2
3  1E-3
4  1E-4
5  1E-5
6  1E-6
7  1E-7
8  1E-8
9  1E-9
10 1E-10
11 1E-11
12 1E-12
13 1E-13
14 1E-14
;
run;

/* Define the title. */
title1 h=3.7 "Relationship of pH to H"
       move=(-0,-.75) h=2 "3"
       move=(+0,+.75) h=3.7 "O"
       move=(+0,+1.5) h=2 "+"
       move=(-0,-1.5) h=3.7 " Concentration";


/* Define the symbol characteristics. */
symbol value=dot color=black height=2;


/* Define the horizontal axis characteristics. */
axis1 label=(h=3 "Scale of pH Values"
             justify=left color=red h=2 "More acid"
             justify=right color=blue "More alkaline")
      minor=none
      length=60
      offset=(2,2);

/* Define the vertical axis characteristics. */
axis2 logbase=10
      logstyle=expand
      label=(angle=90 h=2 color=black
             "Concentration (Moles/Liter)" )
      value=(tick=1 "10" height=1.2 "-14"
             tick=2 "10" height=1.2 "-13"
             tick=3 "10" height=1.2 "-12"
             tick=4 "10" height=1.2 "-11"
             tick=5 "10" height=1.2 "-10"
             tick=6 "10" height=1.2 "-9"
             tick=7 "10" height=1.2 "-8"
             tick=8 "10" height=1.2 "-7"
             tick=9 "10" height=1.2 "-6"
             tick=10 "10" height=1.2 "-5"
             tick=11 "10" height=1.2 "-4"
             tick=12 "10" height=1.2 "-3"
             tick=13 "10" height=1.2 "-2"
             tick=14 "10" height=1.2 "-1")
      offset=(3,3);

/* Generate the plot and assign AXIS definitions. */
proc gplot data= concentr;
   plot conc*pH / haxis=axis1
                  vaxis=axis2
                  autohref chref=graydd
                  autovref cvref=graydd;
run;
quit;
