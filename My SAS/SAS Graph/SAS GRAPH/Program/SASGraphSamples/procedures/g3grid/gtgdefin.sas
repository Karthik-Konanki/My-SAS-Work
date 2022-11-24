/*+-------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GTGDEFIN                                           |
  |   TITLE: GTGDEFIN-Default G3GRID Interpolation Method       |
  | PRODUCT: GRAPH                                              |
  |  SYSTEM: ALL                                                |
  |    KEYS: GRAPHICS GOPTIONS G3GRID G3D                       |
  |   PROCS: G3GRID G3D                                         |
  |    DATA: INTERNAL                                           |
  |                                                             |
  | SUPPORT: GRAPHICS STAFF              UPDATE: 04DEC2007      |
  |     REF: SAS/GRAPH REFERENCE GUIDE                          |
  +-------------------------------------------------------------+*/

 /* set the graphics environment       */
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

/* define the title for the plot */
title 'Scatter Plot of NUMS Data Set';

/* generate the scatter plot           */
proc g3d data=nums;
   scatter y*x=z;
run;
quit;

/* process points with PROC G3GRID     */
proc g3grid data=nums out=default;
   grid y*x=z / axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

/* define the title for the plot */
title 'Surface Plot using Interpolated Data Set';

/* show the surface graph */
proc g3d data=default;
   plot y*x=z;
run;
quit;
