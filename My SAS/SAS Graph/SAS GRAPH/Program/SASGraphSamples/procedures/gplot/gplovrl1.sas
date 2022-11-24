 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLOVRL1                                            |
   |   TITLE: GPLOVRL1-Generating an Overlay Plot                 |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GPLOT AXIS SYMBOL                |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS PLOT USES INTERPOLATION.                      |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /* create the data set STOCKS */
data stocks;    input year high low @@;
datalines;
1956 521.05 462.35 1957 520.77 419.79
1958 583.65 436.89 1959 679.36 574.46
1960 685.47 568.05 1961 734.91 610.25
1962 726.01 535.76 1963 767.21 646.79
1964 891.71 768.08 1965 969.26 840.59
1966 995.15 744.32 1967 943.08 786.41
1968 985.21 825.13 1969 968.85 769.93
1970 842.00 631.16 1971 950.82 797.97
1972 1036.27 889.15 1973 1051.70 788.31
1974 891.66 577.60 1975 881.81 632.04
1976 1014.79 858.71 1977 999.75 800.85
1978 907.74 742.12 1979 897.61 796.67
1980 1000.17 759.13 1981 1024.05 824.01
1982 1070.55 776.92 1983 1287.20 1027.04
1984 1286.64 1086.57 1985 1553.10 1184.96
1986 1955.57 1502.29 1987 2722.42 1738.74
1988 2183.50 1879.14 1989 2791.41 2144.64
1990 2999.75 2365.10 1991 3168.83 2470.30
1992 3413.21 3136.58 1993 3794.33 3241.95
1994 3978.36 3593.35 1995 5216.47 3832.08
;

   /* define titles and footnotes */
title1 "Dow Jones Yearly Highs and Lows";
footnote1 j=l " Source: 1997 World Almanac"
          ;

   /* define symbol characteristics */
symbol1 interpol=join value=dot color=_style_;
symbol2 font=marker value=C  interpol=join color=_style_;

   /* define axis characteristics */
axis1 order=(1955 to 1995 by 5) offset=(2,2)
      label=none
      major=(height=2)
      minor=(height=1)
      ;

axis2 order=(0 to 6000 by 1000) offset=(0,0)
      label=none
      major=(height=2)
      minor=(height=1)
      ;
legend1 label=none position=(top center inside)  mode=share;


   /* generate two plots */
proc gplot data=stocks;
   plot high*year low*year / overlay legend=legend1
                             vref=1000 to 5000 by 1000 lvref=2
                             haxis=axis1 hminor=4
                             vaxis=axis2 vminor=1;
run;
quit;
