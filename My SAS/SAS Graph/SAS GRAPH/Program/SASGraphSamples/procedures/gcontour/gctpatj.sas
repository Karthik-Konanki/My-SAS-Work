/*+------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: GCTPATJ                                                |
   |   TITLE: GCTPATJ - Using Patterns and Joins                     |
   | PRODUCT: GRAPH                                                  |
   |  SYSTEM: ALL                                                    |
   |    KEYS: GRAPHICS GCONTOUR                                      |
   |   PROCS: GCONTOUR                                               |
   |    DATA: SWIRL                                                  |
   |                                                                 |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 26NOV2007                |
   |     REF: SAS/GRAPH REFERENCE GUIDE                              |
   +-----------------------------------------------------------------+*/


/*   Set the graphics options.                                        */
goptions reset=all border;

/*   Create the SWIRL data set.                                       */
data swirl;
    do x= -5 to 5 by 0.25;
       do y= -5 to 5 by 0.25;
          if x+y=0 then z=0;
             else z=(x*y)*((x*x-y*y)/(x*x+y*y));
          output;
       end;
    end;
run;

/*   Set the title and the footnote.                                  */
title1 "Line Contour Levels";
footnote1 j=r "GCTPATR1";

/*   Generate a plot with lines representing contour levels.          */
proc gcontour data=swirl;
   plot y*x=z;
run;
quit;

/*   Set the title and the footnote.                                 */
title1 "Pattern Contour Levels";
footnote j=r "GCTPATR2";

/*   Generate a plot with patterns representing contour levels.      */
proc gcontour data=swirl;
   plot y*x=z /
      ctext=green
      coutline=gray
      pattern;
run;
quit;

/* Set the title and the footnote.                                   */
title1 "Contour Plot with Joined Cells";
footnote j=r "GCTPATR3";


/* AXIS statement attributes are modified change the values,color
/* and width,                                                        */
/* remove label.                                                     */
axis1 label=none
    value=("-5" '' "0" '' "5")
    color=red
     width=3;

axis2 label=none
     value=("-5" '' "0" '' "5")
     color=red
     width=3;

/*   LEGEND statement attributes are modified add                    */
/*   a frame around the legend.                                      */
legend1 frame;

/*   Generate a plot with joined cells.                              */
proc gcontour data=swirl;
   plot y*x=z /
      haxis=axis1
      join
      legend=legend1
      pattern
      vaxis=axis2;
run;
quit;
