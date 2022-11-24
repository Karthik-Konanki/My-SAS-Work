 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GBYGMSC1                                            |
   |   TITLE: GBYGMSC1-Using BY-groups to Make a Series of Charts |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS PATTERN GCHART                       |
   |   PROCS: SORT GCHART                                        |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07         |
   | UPDATE CODE to Match Doc Code        UPDATE: MAY 2020       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/


   /* set the graphics environment */
goptions reset=all border ;
   /* add the data set GRAINLDR */
data grainldr;
   length country $ 3 type $ 5;
   input year country $ type $ amount;
   megtons=amount/1000;
   datalines;
1995 BRZ  Wheat    1516
1995 BRZ  Rice     11236
1995 BRZ  Corn     36276
1995 CHN  Wheat    102207
1995 CHN  Rice     185226
1995 CHN  Corn     112331
1995 INS  Wheat    .
1995 INS  Rice     49860
1995 INS  Corn     8223
1995 USA  Wheat    59494
1995 USA  Rice     7888
1995 USA  Corn     187300
1996 BRZ  Wheat    3302
1996 BRZ  Rice     10035
1996 BRZ  Corn     31975
1996 IND  Wheat    62620
1996 IND  Rice     120012
1996 IND  Corn     8660
1996 USA  Wheat    62099
1996 USA  Rice     7771
;

   /* create a format for the values of COUNTRY  */
proc format;
   value $country "BRZ" = "Brazil"
                  "CHN" = "China"
                  "IND" = "India"
                  "INS" = "Indonesia"
                  "USA" = "United States";
run;

   /* suppress the default BY-line */
option nobyline;

   /* define title and footnote for chart */
title1 "Leading #byval(type) Producers" 
        j=c "1995 and 1996";
footnote1 j=r "GBYGMSC1 ";

   /* define pattern characteristics */
pattern1 color=green;

   /* define response axis characteristics */
axis1 order=(0 to 550 by 100)
      label=(angle=90 "Millions of Metric Tons")
      major=none
      minor=none
      value=none
      style=0
      noplane;

   /* define midpoint axis characteristics */
axis2 label=none
      split=" ";

   /* sort data set TOTALS in order by site */
proc sort data= grainldr out=temp;
   by type;
run;

   /* generate vertical bar chart */
   /* using GROUP=SITE            */
proc gchart data=temp (where=(megtons gt 31));
   by type;
   format country $country.;
   vbar3d country / sumvar=megtons
                    outside=sum
                    descending
                    shape=hexagon
                    width=8
                    coutline=black
                    cframe=grayaa
                    maxis=axis2
                    raxis=axis1 name="GBYGMSC1";
run;
quit;
