 /*+-----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                          |
   |                                                                       |
   |    NAME: SGSCCM1                                                      |
   |   TITLE: SGSCCM1-Creating a Comparative Panel with Fits and Ellipses  |
   | PRODUCT: BASE                                                         |
   |  SYSTEM: ALL                                                          |
   |    KEYS: SGSCATTER COMPARE                                            |
   |   PROCS: SGSCATTER                                                    |
   |    DATA: EXTERNAL                                                     |
   |                                                                       |
   | SUPPORT: BASE STAFF                             UPDATE: NOV 2010      |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                            |
   +-----------------------------------------------------------------------+*/

proc sgscatter data=sashelp.iris(where=(species="Versicolor"));
  title "Versicolor Length and Width";

  /*Create the comparative panel.
  REG adds a regression curve.
  ELLIPSE adds a confidence ellipse.
  SPACING= specifies the number of pixels between each cell.
  */

  compare y=(sepalwidth petalwidth)
          x=(sepallength petallength)
          / reg ellipse=(type=mean) spacing=4;
run;

title;
