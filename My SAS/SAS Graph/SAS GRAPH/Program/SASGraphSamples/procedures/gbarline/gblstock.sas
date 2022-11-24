 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GBLSTOCK                                           |
   |   TITLE: GBLSTOCK-Basic Bar Line Chart with Styles          |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GBARLINE                                  |
   |   PROCS: GBARLINE                                           |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07         |
   |                                      UPDATE: MAY2020        |
   | Subsituted more recent dates, removed listing destination   |
   | replaced inaccurate data, added bar options                 |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

goptions reset=all border;
data nyse;
   format Day $5.;
   format High Low Close comma12.;
   format Volume comma12.;
   input Day High Low Close Volume;
datalines;
01MAY 11187.77 11011.46 11058.57 4753160
04MAY 11061.96 10900.39 11056.28 4723140
05MAY 11259.20 11124.69 11135.40 5129590
06MAY 11204.53 10999.99 10999.99 4861920
07MAY 11228.25 11109.56 11121.67 5164640
;
run;

title1 "NYSE Closing Price and Volume - 2020";
footnote j=r "GBLSTOCK";

proc gbarline data=nyse;
   bar day / discrete sumvar=volume space=4;
   plot / sumvar=close;
run;
quit;

