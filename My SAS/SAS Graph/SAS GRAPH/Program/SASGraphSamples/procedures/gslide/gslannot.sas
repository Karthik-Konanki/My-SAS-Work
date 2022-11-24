 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GSLANNOT                                           |
   |   TITLE: GSLANNOT-Displaying Annotate Graphics              |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GSLIDE ANNOTATE                  |
   |   PROCS: GSLIDE                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:                                                    |
   |                                                             |
   +-------------------------------------------------------------+*/

   /* set graphics environment */
goptions reset=all colors=(black blue green red)
         hsize=5.5in vsize=4.12in border;

   /* create Annotate data set */
data art;
   length function color style $ 8;
   input function $ x y color $ style $;
   xsys="5"; ysys="5";
   datalines;
poly      30  20  blue    solid
polycont  50  20  .       .
polycont  40  50  .       .
poly      50  20  green   x1
polycont  70  50  .       .
polycont  60  50  .       .
poly      40  50  red     l1
polycont  60  50  .       .
polycont  50  80  .       .
;

   /* define titles and footnotes */
title "Number 17";
footnote1 h=2 "'Art is anything you can get away with.'";
footnote2 j=r "D. H. Benson   ";

footnote4 angle=90;
footnote5  angle=-90;

   /* generate annotated slide */
proc gslide annotate=art
            border
            wframe=6
            cframe=red;
run;
quit;
