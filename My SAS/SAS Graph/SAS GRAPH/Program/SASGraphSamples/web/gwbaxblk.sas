 /*+------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GWBAXBLK                                           |
  |   TITLE: GWBAXBLK-Generating an Interactive Block Diagram   |
  | PRODUCT: GRAPH                                              |
  |  SYSTEM: ALL, run HTML output in Windows                    |
  |    KEYS: GRAPHICS ACTIVEX GCHART ODS                        |
  |   PROCS: GCHART                                             |
  |    DATA: INTERNAL                                           |
  |                                                             |
  | SUPPORT: GRAPHICS STAFF              UPDATE: 20APR2020      |
  |     REF: SAS/GRAPH REFERENCE GUIDE                          |
  |    MISC: The HTML output file runs an ACTIVEX control from  |
  |          SAS, which must be installed on the host prior to  |
  |          displaying the HTML file in a Web browser.         |
  +-------------------------------------------------------------+*/

/* Create a fileref for the ODS output */
filename odsout "output-path";

/* Close the currently open ODS destinations.  */
ods _all_ close;

/* Open ODS HTML and specify the output path and filename.  */
ods html path=odsout file="filename.htm";

/* Specify the ACTIVEX driver and set up customizations. */
goptions reset=all
         device=activex
         xpixels=500 ypixels=350
         cback=white
         border;

/* Specify the data for the block chart. */
data advertising;
format Revenue dollar12.;
Input Media $ 1-18 Year Revenue Share;
datalines;
Newspapers        1985 25170 26.6
Newspapers        1990 32280 25.1
Newspapers        1995 36092 22.5
Newspapers        1996 38075 21.8
Newspapers        1997 41341 22.1
Magazines         1985 5155  5.4
Magazines         1990 6803  5.3
Magazines         1995 8580  5.3
Magazines         1996 9010  5.2
Magazines         1997 9821  5.3
Farm Publications 1985 186   0.2
Farm Publications 1990 215   0.2
Farm Publications 1995 283   0.2
Farm Publications 1996 297   0.2
Farm Publications 1997 325   0.2
Broadcast TV      1985 20298 21.4
Broadcast TV      1990 26616 20.7
Broadcast TV      1995 32720 20.0
Broadcast TV      1996 36046 20.6
Broadcast TV      1997 36893 19.7
Cable             1985 724   0.7
Cable             1990 1789  1.4
Cable             1995 5108  3.2
Cable             1996 6438  3.7
Cable             1997 7626  4.0
Radio             1985 6490  6.8
Radio             1990 8726  6.8
Radio             1995 11338 7.1
Radio             1996 12269 7.0
Radio             1997 13491 7.2
Direct Mail       1985 15500 16.4
Direct Mail       1990 23370 18.2
Direct Mail       1995 32866 20.5
Direct Mail       1996 34509 19.7
Direct Mail       1997 36890 19.7
Business Papers   1985 2375  2.5
Business Papers   1990 2875  2.2
Business Papers   1995 3559  2.2
Business Papers   1996 3808  2.2
Business Papers   1997 4109  2.2
Outdoor           1985 945   1.0
Outdoor           1990 1084  0.8
Outdoor           1995 1263  0.8
Outdoor           1996 1339  0.8
Outdoor           1997 1455  0.8
Yellow Pages      1985 5800  6.1
Yellow Pages      1990 8926  6.9
Yellow Pages      1995 10236 6.4
Yellow Pages      1996 10849 6.2
Yellow Pages      1997 11423 6.1
Miscellaneous     1985 12107 12.8
Miscellaneous     1990 15955 12.4
Miscellaneous     1995 20660 12.6
Miscellaneous     1996 22263 12.7
Miscellaneous     1997 23827 12.7
;
run;
title1 "Advertising Revenue Growth";

proc gchart data=advertising;
block Year / group=Media
             sumvar=Revenue
             discrete
             pattid=group
             cframe=CXE2F7FE
             shape=cylinder
;
run;
quit;

/* Close the ODS HTML destination. */
ods html close;
