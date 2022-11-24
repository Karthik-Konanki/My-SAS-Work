/*+----------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                  |
   |                                                               |
   |    NAME: GCTLAKE                                              |
   |   TITLE: GCTLAKE - Simple Contour                             |
   | PRODUCT: GRAPH                                                |
   |  SYSTEM: ALL                                                  |
   |    KEYS: GRAPHICS ODS GCONTOUR                                |
   |   PROCS: GCONTOUR                                             |
   |    DATA: SASHELP.LAKE                                         |
   |                                                               |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 26NOV2007              |
   |     REF: SAS/GRAPH REFERENCE GUIDE                            |
   +---------------------------------------------------------------+*/


/*   Set graphic options.                                           */
goptions reset=all border;

/*   Set title and footnote.                                        */

title "Lake Data";
footnote j=r "GCTLAKE";

/*   Plot the dimensions of the lake and the contour levels.        */

proc gcontour data=sashelp.lake;
   plot length*width=depth;
run;
quit;
