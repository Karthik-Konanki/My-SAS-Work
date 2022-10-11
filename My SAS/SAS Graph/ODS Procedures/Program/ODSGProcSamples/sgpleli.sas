 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLELI                                            |
   |   TITLE: SGPLELI-Adding a Prediction Ellipse to a Scatter   |
   |          Plot                                               |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT SCATTER ELLIPSE KEYLEGEND                   |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgplot data=sashelp.iris;
  title "Iris Petal Dimensions";
  scatter x=petallength y=petalwidth;
  ellipse x=petallength y=petalwidth;

 /* Position the Legend.
 The LOCATION= option places the legend inside of the data area.
 The POSITION= option places the legend at the bottom right.    */

  keylegend / location=inside position=bottomright;
run;
title;
