/*+-----------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                   |
   |                                                                |
   |    NAME: GCTNLVEL                                              |
   |   TITLE: GCTNLVEL - Specifying Contour Levels                  |
   | PRODUCT: GRAPH                                                 |
   |  SYSTEM: ALL                                                   |
   |    KEYS: GRAPHICS GCONTOUR                                     |
   |   PROCS: GCONTOUR                                              |
   |    DATA: POLLEN                                                |
   |                                                                |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 26NOV2007               |
   |     REF: SAS/GRAPH REFERENCE GUIDE                             |
   +----------------------------------------------------------------+*/


/*   Set the graphics options.                                       */
goptions reset=all border;

/*   Create the POLLEN data set.                                     */
data pollen;
input Week Workdays Pollen @@;
datalines;
1 1 50 1 2 96 1 3 28 1 4 94 1 5 124 2 1 204 2 2 153 2 3 43 2 4 21 2 5 60
3 1 37 3 2 23 3 3 57 3 4 21 3 5 65 4 1 8 4 2 144 4 3 22 4 4 141 4 5 95
;
run;

/*   Set the title and the footnote.                                 */
title "The Amount of Pollen Particles in a Cubic Meter of Air";
footnote j=r "GCTNLVEL";

/* AXIS statement attributes are modified to order the vertical axis.*/
axis1 order=(1 to 4 by 1);

/*   Plot the amount of pollen in the air for 5 work days (x-axis)   */
/*   in a 4 week series (y-axis).                                    */
/*   Use the NLEVELS= option to specify the number of
/*   contour levels to plot for the z variable.                      */
proc gcontour data=pollen;
   plot week*workdays=pollen/
      hminor=0
      llevels= 2 20 21 33 25 41
      nlevels=6
      vaxis=axis1
      vminor=0;
run;
quit;
