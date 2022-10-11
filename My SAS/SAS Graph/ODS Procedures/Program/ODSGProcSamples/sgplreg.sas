 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLREG                                            |
   |   TITLE: SGPLREG-Adding Prediction and Confidence Bands     |
   |          to a Regression Plot                               |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT REG                                         |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgplot data=sashelp.class;
  reg x=height y=weight / CLM CLI;
run;
