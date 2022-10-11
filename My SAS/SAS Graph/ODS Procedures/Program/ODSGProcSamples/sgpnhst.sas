 /*+--------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                       |
   |                                                                    |
   |    NAME: SGPNHST                                                   |
   |   TITLE: SGPNHST-Creating a Panel of Histograms and Density Plots  |
   | PRODUCT: BASE                                                      |
   |  SYSTEM: ALL                                                       |
   |    KEYS: SGPANEL PANELBY HISTOGRAM DENSITY                         |
   |   PROCS: SGPANEL                                                   |
   |    DATA: EXTERNAL                                                  |
   |                                                                    |
   | SUPPORT: BASE STAFF                          UPDATE: NOV 2010      |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                         |
   +--------------------------------------------------------------------+*/

proc sgpanel data=sashelp.heart noautolegend;
  title "Cholesterol Distribution in Heart Study";

  /*Specify the classification variable.*/

  panelby sex;

  /*Create the histogram and density plots.*/

  histogram cholesterol;
  density cholesterol;
run;
