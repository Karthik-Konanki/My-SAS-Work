 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPNREG                                            |
   |   TITLE: SGPNREG-Creating a Panel of Regression Curves      |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPANEL PANELBY REG                                |
   |   PROCS: SGPANEL                                            |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE     STAFF              UPDATE: NOV 2010       |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgpanel data=sashelp.iris;
  title "Scatter plot for Fisher iris data";

  /*Specify the classification variable.
  COLUMNS= specifies the number of columns in the panel.*/

   panelby species / columns=3;

  /*Create the regression curve.
  CLI adds individual prediction limits.
  CLM adds mean value confidence limits.*/

  reg x=sepallength y=sepalwidth / cli clm;
run;
title;
