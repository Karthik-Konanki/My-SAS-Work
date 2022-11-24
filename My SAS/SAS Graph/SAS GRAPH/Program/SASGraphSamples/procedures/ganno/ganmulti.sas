 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GANMULTI                                           |
   |   TITLE: GANMULTI-Using NAME= to Produce Multiple Graphs    |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS ANNOTATE GANNO                            |
   |   PROCS: GANNO                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 02NOV2007      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

 /* create Annotate data set */
data squares;
   length function style color $ 8 text $ 15;
   xsys='3'; ysys='3';

      /* draw the green square */
   color='green';
   function='move'; x=10; y=65; output;
   function='bar';  x=30; y=95; style='solid'; output;

      /* label green square */
   function='label'; x=10; y=63; position='6';
      style='swissb'; size=2; text='Green'; output;

      /* draw the red square */
   color='red';
   function='move'; x=60; y=65; output;
   function='bar';  x=80; y=95; output;

      /* label red square */
   function='label'; x=60; y=63; position='6';
      style='swissb'; size=2; text='Red'; output;

      /* draw the blue square */
   color='blue';
   function='move'; x=10; y=15; output;
   function='bar';  x=30; y=45; output;

      /* label blue square */
   function='label'; x=10; y=12; position='6';
      style='swissb'; size=2; text='Blue'; output;

      /* draw the gray square */
   color='gray';
   function='move'; x=60; y=15; output;
   function='bar';  x=80; y=45; output;

      /* label gray square and add a footnote */
   function='label'; x=60; y=12; position='6';
      style='swissb'; size=2; text='Gray'; output;

         /* write footnote */
      x=90; y=5; position='5'; hsys='3'; size=3;
         style='swiss'; text='GANSQUAR';

      /* draw a red frame */
   function='frame'; color='red'; when='b'; style='empty';
      output;
run;

   /* generate annotated slide, separating */
   /* graphs by color                      */
proc ganno annotate=squares
           name=color
           description='Individual squares';
run;
quit;
