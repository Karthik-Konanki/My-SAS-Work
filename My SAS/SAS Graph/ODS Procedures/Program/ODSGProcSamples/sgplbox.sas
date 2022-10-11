 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLBOX                                            |
   |   TITLE: SGPLBOX-Creating a Horizontal Box Plot             |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT HBOX                                        |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgplot data=sashelp.heart;
  title "Cholesterol Distribution by Weight Class";

  /*Create the box plot.
  CATEGORY= specifies the category variable.*/

  hbox cholesterol / category=weight_status;
run;

title;
