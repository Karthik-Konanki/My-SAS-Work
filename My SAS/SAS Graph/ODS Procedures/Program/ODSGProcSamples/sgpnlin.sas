 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPNLIN                                            |
   |   TITLE: SGPNLIN-Creating a Panel of LINE Charts            |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPANEL PANELBY VLINE                              |
   |   PROCS: SGPANEL                                            |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

 proc sgpanel data=sashelp.prdsale;
  where product in ('CHAIR' 'SOFA');
  title "Yearly Sales by Product";

  /*Specify the classification variable.
  NOVARNAME hides the variable name in the cell headings.
  SPACING= specifies the number of pixels between each cell.
  */

  panelby year / spacing=5 novarname;

  /*Create the bar chart.
  RESPONSE= specifies the response variable.
  GROUP= specifies a group variable. */

  vline month / response=actual group=product;
run;
title;
