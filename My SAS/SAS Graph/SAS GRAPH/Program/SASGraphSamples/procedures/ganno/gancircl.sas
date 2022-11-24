 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GANCIRCL                                           |
   |   TITLE: GANCIRCL-Drawing a Circle of Stars                 |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS ANNOTATE GSLIDE MACRO                     |
   |   PROCS: GSLIDE GANNO                                       |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 01JUL2007      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:                                                    |
   |                                                             |
   +-------------------------------------------------------------+*/

    /* set the graphics environment */
goptions reset=all border;

data flag;
   length function color style $ 8 text $ 30;
   retain xsys ysys hsys '3';

      /* draw the frame */
   function='frame'; output;

      /* define the title */
   function='label'; x=50; y=90; text='Flag of Micronesia';
      style=''; size=6; output;

     /* draw the background */
   function='move'; x=20; y=30; output;
   function='bar'; x=80; y=80; color='blue';
      line=3; style='solid'; output;

     /* draw the circle of stars */
   do star_ang=0 to 270 by 90;
      function='piecntr'; x=50; y=55; size=15; output;
      function='piexy'; size=1; angle=star_ang; output;
      function='cntl2txt'; output;
      function='symbol'; style='marker'; text='V';
         angle=0; color='white'; size=10; x=.; y=.;
         output;
   end;
run;

   /* generate the output from */
   /* the Annotate data set    */
proc ganno annotate=flag;
run;
quit;
