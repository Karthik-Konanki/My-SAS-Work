 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGSCMAT                                            |
   |   TITLE: SGSCMAT-Creating a Scatter Plot Matrix             |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGSCATTER MATRIX                                   |
   |   PROCS: SGSCATTER                                          |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

 proc sgscatter data=sashelp.iris;
   title "Scatterplot Matrix for Iris Data";

   /*Create the scatter plot matrix.
   GROUP= specifies a group variable.*/

   matrix sepallength petallength sepalwidth petalwidth
          / group=species;
 run;

 title;
