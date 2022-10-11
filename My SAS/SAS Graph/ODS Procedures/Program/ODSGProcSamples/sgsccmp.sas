 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGSCCMP                                            |
   |   TITLE: SGSCCMP-Creating a Simple Comparative Panel        |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGSCATTER COMPARE                                  |
   |   PROCS: SGSCATTER                                          |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgscatter data=sashelp.iris;
  title "Iris Data: Length and Width";

  /*Create the comparative panel.
  GROUP= specifies a group variable.*/

  compare x=(sepallength petallength)
          y=(sepalwidth petalwidth)
          / group=species;
run;

title;
