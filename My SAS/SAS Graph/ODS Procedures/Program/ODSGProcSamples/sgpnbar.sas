 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPNBAR                                            |
   |   TITLE: SGPNBAR-Creating a Panel of Bar Charts             |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPANEL PANELBY HBAR                               |
   |   PROCS: SGPANEL                                            |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgpanel data=sashelp.prdsale;
  title "Yearly Sales by Product";

  /*Specify the classification variable.
  NOVARNAME hides the variable name in the cell headings.
  COLUMNS= specifies the number of columns.
  */

  panelby year / novarname columns=1;

  /*Create the bar chart.
  RESPONSE= specifies the response variable.*/

  hbar product / response=actual;
run;
title;
