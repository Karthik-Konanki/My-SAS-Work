 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLCLU                                            |
   |   TITLE: SGPLCLU-Clustering a Grouped Scatter Plot          |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT SCATTER GROUPDISPLAY CLUSTERWIDTH           |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/


proc sgplot data=sashelp.revhub2;

  /* Create the scatter plot.
  GROUPDISPLAY specifies that the grouped markers are clustered.
  CLUSTERWIDTH specifies the width of the group clusters.*/
  scatter x=hub y=revenue
    / group=type groupdisplay=cluster clusterwidth= 0.5;

  /* Specify that the category axis be discrete. */
  xaxis type=discrete;
run;
