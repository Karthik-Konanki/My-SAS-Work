 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GRECRCM1                                           |
   |   TITLE: GRECRCM1-Creating a Color Map                      |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GREPLAY                          |
   |   PROCS: GREPLAY                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 07DEC07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: THIS PROGRAM CREATES A PERMANENT GRAPHICS CATALOG. |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /* start the GREPLAY procedure */
proc greplay cc=clrmap nofs;

      /* define a color map */
   cdef mycolor des='Special Color Map'
        1 / pink  : red
        2 / cyan  : blue
        3 / lig   : green;

      /* specify current color map */
   cmap mycolor;

      /* list the contents of the color map */
   list cmap;
quit;
