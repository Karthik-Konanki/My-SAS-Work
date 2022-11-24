 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRERGOT1                                           |
   |   TITLE: GRERGOT1-Replaying Graphics Output into a Template |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GREPLAY GSLIDE                   |
   |   PROCS: GREPLAY GSLIDE                                     |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 27MAR2015      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THE TREPLAY STATEMENT REPLAYS GRAPHICS INTO THE    |
   |          TEMPLATE GRFTMPLT,THE FOUR CATALOG ENTRIES THAT    |
   |          THAT CONTAIN GRAPHICS OUTPUT.
   +-------------------------------------------------------------+*/


/* set the graphics environment               */
/* suppress the graphics display              */
/* adjust hsize and vsize for template panels */
goptions reset=all border
         hsize=5.14in vsize=4.2in;

/* generate the three smaller graphs */
proc gslide gout=grafcat;
   title c=navy  "Graph Number Three";
run;
   title c=lime "Graph Number One";
run;
   title c=orange "Graph Number Two";
run;

/* generate a container graph */
proc gslide gout=grafcat;
   title c=purple "Common Title";
   footnote c=blue "Common Footnote";
run;

/* start the GREPLAY procedure */
proc greplay igout=grafcat gout=excat
             tc=tempcat nofs;

/* define a template */
tdef newtemp des='Five Panel Template'

   /* define panel 1 */
   1/llx=0   lly=10
      ulx=0   uly=50
      urx=50  ury=50
      lrx=50  lry=10
      color=navy

   /* define panel 2 */
   2/llx=0   lly=50
      ulx=0   uly=90
      urx=50  ury=90
      lrx=50  lry=50
      color=lime

   /* define panel 3 */
   3/llx=50  lly=50
      ulx=50  uly=90
      urx=100 ury=90
      lrx=100 lry=50
      color=yellow

   /* define panel 4 */
   4/llx=50  lly=10
      ulx=50  uly=50
      urx=100 ury=50
      lrx=100 lry=10
      color=cyan

   /* define panel 5 */
   5/llx=0   lly=0
      ulx=0   uly=100
      urx=100 ury=100
      lrx=100 lry=0
      color=lipk;

/* assign current template */
template newtemp;

   /* list contents of current template */
   list template;


   /* replay three graphs into template */
   treplay 1:gslide
           2:gslide1
           3:gslide2
           5:gslide3;
quit;
