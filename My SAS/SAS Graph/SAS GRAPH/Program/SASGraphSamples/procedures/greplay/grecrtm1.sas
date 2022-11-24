 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRECRTM1                                           |
   |   TITLE: GRECRTM1-Creating a Template                       |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GREPLAY                          |
   |   PROCS: GREPLAY                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 07Dec07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS PROGRAM CREATES A TEMPORARY GRAPHICS CATALOG. |
   +-------------------------------------------------------------+*/



   /* set the graphics environment */
goptions reset=all border;

   /* start the GREPLAY procedure */
proc greplay tc=tempcat nofs;

      /* define a template */
   tdef newtemp des="ive Panel Template"
           /* define panel 1 */
        1/llx=0   lly=10
          ulx=0   uly=50
          urx=50  ury=50
          lrx=50  lry=10
          color=blue

           /* define panel 2 */
        2/llx=0   lly=50
          ulx=0   uly=90
          urx=50  ury=90
          lrx=50  lry=50
          color=red

           /* define panel 3 */
        3/llx=50  lly=50
          ulx=50  uly=90
          urx=100 ury=90
          lrx=100 lry=50
          color=green

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
quit;
