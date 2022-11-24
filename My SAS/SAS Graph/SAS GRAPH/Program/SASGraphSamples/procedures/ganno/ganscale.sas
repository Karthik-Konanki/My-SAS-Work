  /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GANSCALE                                           |
   |   TITLE: GANSCALE-Scaling Data-Dependent Output             |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS ANNOTATE GANNO                            |
   |   PROCS: GANNO                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 02NOV2007      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:                                                    |
   |                                                             |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /* create data set of sales information */
data wrldtotl;
   length sitename $ 10;
   input sitename $ 1-10 mean 12-15;
   datalines;
Paris      999
Munich     571
Tokyo      137
London     273
Frankfurt  546
New York   991
;

   /* create Annotate data set */
data wrldanno;
   length function color $ 8 text $ 20;
   retain line 0 xsys ysys '2' hsys '3' x 8;
   set wrldtotl end=end;

      /* position the cursor at the beginning point */
   function='move'; x=x+8; y=20; output;

      /* draw bars representing number of sales */
   function='bar'; y=y+(mean); x=x+9;
      style='empty'; color='red'; output;

      /* label the bars with name of site */
   function='label'; y=0; x=x-4; size=3.5;
      position='E'; style='swiss';
      color='blue'; text=sitename; output;

      /* label the bars with the value of MEAN */
   function='move'; y=y+(mean)-3; output;
   function='label'; x=x-1; text=left(put(mean,3.));
      position='5'; style='swiss'; size=3; output;

      /* at end of data set, add an axis line, */
      /* title, footnote, and frame            */
   if end then do;

         /* draw a blue axis line */
      function='move'; x=10; y=20; output;
      function='draw'; x=90; y=20; line=1;
         size=.5; color='blue'; output;

         /* write the title */
      function='label'; x=50; y=95; text='Projected Sales';
         xsys='3'; ysys='3'; position='5'; style='swissb';
         size=5; color=' '; output;

            /* write the footnote */
         x=92; y=5; size=3; style='swiss'; text='GANSCALE'; output;

         /* draw a frame */
      function='frame'; color='blue'; when='b';
         style='empty'; output;
   end;
run;

   /* display the annotation, scaling  */
   /* the data with the DATASYS option */
proc ganno annotate=wrldanno
           datasys;
run;
quit;
