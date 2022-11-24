/*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GTGPART                                            |
   |   TITLE: GTGPART-Using Partial Spline Interpolation         |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS G3D G3GRID AXIS                  |
   |   PROCS: G3D G3GRID                                         |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 04DEC2007      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

/* set the graphics environment  */
goptions reset=all border;

/* create data set WORK.NUMS using     */
/* a set of randomly sampled points    */
data nums;
   keep x y z;
   do i=1 to 30;
      x=10*ranuni(33)-5;
      y=10*ranuni(35)-5;
      z=sin(sqrt(x*x+y*y));
      output;
   end;
run;


/* process data with PROC G3GRID  */
proc g3grid data=nums out=partial;
   grid y*x=z / partial
                near=8
                axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

/* define title for the plot  */
title "Surface Plot using Partial Spline Interpolation";

/* generate the surface plot */
proc g3d data=partial;
   plot y*x=z;
run;
quit;
