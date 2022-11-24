/*+-------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GTDTILT                                            |
  |   TITLE: GTDTILT - Generating a Tilted Surface Plot         |
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
title 'Tilted Surface Plot';

   /* generate the plot */
proc g3d data=sashelp.lake;
   plot length*width=depth/
      side
      tilt=30;
run;
quit;
