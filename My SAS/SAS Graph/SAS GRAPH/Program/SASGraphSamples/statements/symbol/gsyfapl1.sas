 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GSYFAPL1                                            |
   |   TITLE: GSYFAPL1-Filling the Area between Plot Lines        |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS SYMBOL GPLOT                         |
   |   PROCS: SORT GPLOT                                         |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;
   /* create the data set STOCKS */
data stocks;
   input year @7  hdate date9. @17 high
              @26 ldate date9. @36 low;
   format hdate ldate date9.;
   datalines;


1980  20NOV1980 1000.17  21APR1980  759.13
1981  27APR1981 1024.05  25SEP1981  824.01
1982  27DEC1982 1070.55  12AUG1982  776.92
1983  29NOV1983 1287.20  03JAN1983 1027.04
1984  06JAN1984 1286.64  24JUL1984 1086.57
1985  16DEC1985 1553.10  04JAN1985 1184.96
1986  02DEC1986 1955.57  22JAN1986 1502.29
1987  25AUG1987 2722.42  19OCT1987 1738.74
1988  21OCT1988 2183.50  20JAN1988 1879.14
1989  09OCT1989 2791.41  03JAN1989 2144.64
1990  16JUL1990 2999.75  11OCT1990 2365.10
1991  31DEC1991 3168.83  09JAN1991 2470.30
1992  01JUN1992 3413.21  09OCT1992 3136.58
1993  29DEC1993 3794.33  20JAN1993 3241.95
1994  31JAN1994 3978.36  04APR1994 3593.35
1995  13DEC1995 5216.47  30JAN1995 3832.08
;

   /* restructure the data so that      */
   /* it defines a closed area          */
   /* create the data sets HIGH and LOW */
data high(keep=year value)
     low(keep=year value);
   set stocks;
   value=high; output high;
   value=low; output low;
run;

   /* reverse order of the observations in LOW */
proc sort data=low;
   by descending year;
run;

   /* concatenate HIGH and LOW to create data set AREA */
data area;
   set high low;
run;

   /* define titles and footnote */
title1 "Dow Jones Industrial Average";
title2  "Highs and Lows From 1980 to 1995";
footnote " Source: 1997 World Almanac"
         j=r "GSYFAPL1 ";

   /* define symbol characteristics */
symbol interpol=m3n90  /* map/plot pattern fill  */
       cv=red          /* pattern fill color     */
       co=blue;        /* outline color          */

   /* define axis characteristics */
axis1 order=(1980 to 1995 by 5)
      label=none
      major=(height=2)
      minor=(number=4 height=1)
      offset=(2,2)
      width=3;
axis2 order=(0 to 5500 by 500)
      label=none
      major=(height=1.5)  offset=(0,0)
      minor=(number=1 height=1);

  /* generate plot using data set AREA */
proc gplot data=area;
   plot value*year / haxis=axis1
                     vaxis=axis2
                     vref=(1000 3000 5000);
run;
quit;
