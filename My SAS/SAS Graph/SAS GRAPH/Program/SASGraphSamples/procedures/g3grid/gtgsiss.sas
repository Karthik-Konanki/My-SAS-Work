/*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GTGSISS                                            |
   |   TITLE: GTGSISS-Spline Interpolation and a Smoothed Spline |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS G3D G3GRID AXIS                  |
   |   PROCS: G3D G3GRID                                         |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 04DEC2007      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

/* set the graphics environment */
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

/* define the title for the plot*/
title "Surface Plot using Spline Interpolation";

/* process points with PROC G3GRID */
proc g3grid data=nums out=spline;
   grid y*x=z / spline
                axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

/* generate the surface plot */
proc g3d data=spline;
   plot y*x=z;
run;
quit;

/* define the title for plot */
title "Surface Plot using Spline Interpolation and .05 Smoothing";

 /* process points with PROC G3GRID */
proc g3grid data=nums out=smoothed;
   grid y*x=z / spline
                smooth=.05
                axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

/* generate a surface plot */
proc g3d data=smoothed;
   plot y*x=z;
run;
quit;
