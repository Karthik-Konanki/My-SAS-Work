/*+-------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GTDSURFA                                           |
  |   TITLE: GTDSURFA-Generating a Default Surface Plot         |
  | PRODUCT: GRAPH                                              |
  |  SYSTEM: ALL                                                |
  |    KEYS: GRAPHICS GOPTIONS G3D                              |
  |   PROCS: G3D                                                |
  |    DATA: SASHELP.LAKE                                       |
  |                                                             |
  | SUPPORT: GRAPHICS STAFF              UPDATE: 17DEC2010      |
  |     REF: SAS/GRAPH REFERENCE GUIDE                          |
  +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

/* define the title for the plot */
title 'Surface Plot';

   /* generate the plot */
proc g3d data=sashelp.lake;
   plot length*width=depth;
run;
quit;
