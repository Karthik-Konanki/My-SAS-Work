/*+-------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GTDROTAT                                           |
  |   TITLE: GTDROTAT - Generating a Rotated Surface Plot       |
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
title 'Rotated Surface Plot';

   /* generate the plot */
proc g3d data=sashelp.lake;
   plot length*width=depth/
      ctop=green
      grid
      rotate=45
      zmax=5
      zmin=-50;
run;
quit;
