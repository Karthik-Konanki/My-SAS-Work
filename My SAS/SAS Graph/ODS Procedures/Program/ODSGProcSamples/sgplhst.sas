 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLHST                                            |
   |   TITLE: SGPLHST-Combining Histograms with Density Plots    |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT HISTOGRAM DENSITY KEYLEGEND                 |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgplot data=sashelp.heart;
  title "Cholesterol Distribution";

  /*Create the Histogram.*/

  histogram cholesterol;

  /*Create the density plots.
  TYPE= specifies the type of density equation.*/

  density cholesterol;
  density cholesterol / type=kernel;

  /* Position the Legend.
  The LOCATION= option places the legend inside of the data area.
  The POSITION= option places the legend at the top right. */

  keylegend / location=inside position=topright;
run;
title;
