 /*+--------------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                             |
   |                                                                          |
   |    NAME: SGSCPLT                                                         |
   |   TITLE: SGSCPLT-Creating a Graph with Multiple Independent Scatter Plots|
   | PRODUCT: BASE                                                            |
   |  SYSTEM: ALL                                                             |
   |    KEYS: SGSCATTER PLOT                                                  |
   |   PROCS: SGSCATTER                                                       |
   |    DATA: EXTERNAL                                                        |
   |                                                                          |
   | SUPPORT: BASE STAFF                                UPDATE: NOV 2010      |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                               |
   +------------------------------------------------------------------------+*/

proc sgscatter data=sashelp.iris(where=(species="Virginica"));
  title "Multi-Celled Spline Curve for Species Virginica";

  /*Create the multi-celled graph.
  PBSPLINE adds a penalized B-spline curve. */

  plot (sepallength sepalwidth)*(petallength petalwidth)
       / pbspline;
run;

title;
