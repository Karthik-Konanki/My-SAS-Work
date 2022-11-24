/*+-------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GTGSPLIN                                           |
  |   TITLE: GTGSPLIN-Using Spline Interpolation                |
  | PRODUCT: GRAPH                                              |
  |  SYSTEM: ALL                                                |
  |    KEYS: GRAPHICS GOPTIONS G3GRID AXIS                      |
  |   PROCS: G3GRID GCONTOUR                                    |
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
title "Contour Plot using Default Interpolation";

/* define axis characteristics         */
axis1 width=3;

/* process data with PROC G3GRID  */
proc g3grid data=nums out=numdef;
   grid y*x=z / axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

/* generate the contour after default interpolation */
proc gcontour data=numdef;
   plot y*x=z /
      haxis=axis1
      vaxis=axis1;
   run;
quit;

/* define the title for the plot  */
title "Contour Plot using Spline Interpolation";

/* process points with PROC G3GRID  */
proc g3grid data=nums out=numspl;
   grid y*x=z / spline
                axis1=-5 to 5 by .5
                axis2=-5 to 5 by .5;
run;

   /* generate the contour after spline interpolation */
proc gcontour data=numspl;
   plot y*x=z / haxis=axis1 vaxis=axis1;
run;
quit;
