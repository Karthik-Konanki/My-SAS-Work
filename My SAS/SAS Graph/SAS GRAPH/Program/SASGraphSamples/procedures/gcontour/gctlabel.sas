/*+------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: GCTLABEL                                               |
   |   TITLE: GCTLABEL-Labeling Contour Lines, Modifying             |
   |          the Horizontal Axis,                                   |
   |          Modifying the Horizontal Axis, Modifying the Legend    |
   | PRODUCT: GRAPH                                                  |
   |  SYSTEM: ALL                                                    |
   |    KEYS: GRAPHICS GCONTOUR                                      |
   |   PROCS: GCONTOUR                                               |
   |    DATA: SASHELP.LAKE                                           |
   |                                                                 |
   | SUPPORT: GRAPHICS STAFF           UPDATE: 26NOV2007             |
   | Chg font from Arial to Albany AMT UPDATE: 14MAY2020             |
   |     REF: SAS/GRAPH REFERENCE GUIDE                              |
   +-----------------------------------------------------------------+*/


/*   Set the graphics options.                                        */
goptions reset=all border;

/*   Set the title and footnote.                                      */
title "Lake Data";
footnote j=r "GCTLABEL";

/*   SYMBOL1 and SYMBOL7 assign text labels, text fonts, text height, */
/*   and text and                                                     */
/*   line color for the first and seventh contour level lines.        */
/*   SYMBOL2-SYMBOL6 define the text height,and the text color and    */
/*   the line color for contour level lines 2-6.                      */

symbol1 value="DEEP"
        color=red
        font="Albany AMT"
        height=.6;
symbol2 color=green
        height=.45;
symbol3 color=blue
        height=.45;
symbol4 color=orange
        height=.45;
symbol5 color=purple
        height=.45;
symbol6 color=magenta
        height=.45;
symbol7 value="Shallow"
        color=navy
        font="Albany AMT"
        height=.7;

/* LEGEND statement attributes are modified to                         */
/* reposition the legend closer to the data.                           */

legend1 position=(right middle)
        label=(position=top)
        across=1;
/* AXIS statement attributes are modified to define number
/* of major tick marks and remove minor tick marks.                    */
axis1 order=(0 to 10 by 2) minor=none;

/*   Plot the dimensions of the lake and the contour levels.           */
/*   Label the contour lines.                                          */
/*   Specify the name of the catalog entry for the graph               */
proc gcontour data=sashelp.lake;
   plot length*width=depth/
      autolabel=(check=none)
      haxis=axis1
      legend=legend1;
      name="GCTLABEL";
run;
quit;
