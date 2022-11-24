 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GTIENTI1                                           |
   |   TITLE: GTIENTI1-Enhancing Titles                          |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GSLIDE TITLE FOOTNOTE                     |
   |   PROCS: GSLIDE                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 28FEB13        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

   /* Set the graphics environment. */
goptions reset=all border hsize=5in vsize=3.8in;

   /* Define titles. */
title1 "This is TITLE1"
       height=4;
title3 underlin=1
       "TITLE3 is"
       color=purple
       " Underlined";
title4 color=red
       angle=-90
       "TITLE4 is Angled -90 and Positioned on the Right Side of the Output";
title5 color=brown
       rotate=25
       "TITLE5 is Rotated";
title7 color=green
       box=1
       "TITLE7 is Boxed";
title9 color=black
       box=3
       blank=yes
       bcolor=yellow
       color=blue
       angle=-25
       "TITLE9 is Not Overlaid By TITLE10";
title10 color=purple
        draw=(20,35 20,27 58,27 58,35 20,35)cells
        move=(20,32)
        font=script
        "TITLE10 is in Script and "
        move=(20,27)
        height=2
        "is Partially Boxed, Positioned"
        move=(20,22)
        height=2
        "with Explicit Moves, and is Overlaid by TITLE9";

   /* Display titles. */
proc gslide;
run;
quit;
