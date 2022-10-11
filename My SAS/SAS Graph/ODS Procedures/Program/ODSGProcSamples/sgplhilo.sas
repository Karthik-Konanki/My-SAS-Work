 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLHILO                                            |
   |   TITLE: SGPLHILO-Creating a High-Low Plot                  |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT HIGHLOW                                  |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/


title "Stock High, Low, and Close";

proc sgplot data=sashelp.stocks;
  where Date >= '01JAN2005'd and stock='IBM';
  highlow x=date high=high low=low / close=close;
run;

title;
