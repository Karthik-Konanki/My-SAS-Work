 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GPLVRBL1                                            |
   |   TITLE: GPLVRBL1-Plotting Two Variables                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GPLOT SYMBOLS                    |
   |   PROCS: GPLOT                                              |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: NOV 07        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/


    /* set the graphics environment */
goptions reset=all border;

   /* define title and footnotes */
title "Study of Height vs Weight";
footnote1 j=l " Source: T. Lewis & L. R. Taylor";
footnote2 j=l " Introduction to Experimental Ecology"
          ;
   /* generate scatter plot */
proc gplot data= sashelp.class;
   plot height*weight;
run;

footnote1;


   /* define symbol characteristics for second output graphic */
symbol1 interpol=rcclm95 /* regression analysis with */
                         /* confidence limits        */
        value=circle    /* plot symbol              */
        cv=darkred      /* plot symbol color        */
        ci=black         /* regression line color    */
        co=blue         /* confidence limits color dotted */
        width=2;         /* line width               */

      /* generate scatter plot with regression */
   plot height*weight / haxis=45 to 155 by 10
                        vaxis=48 to 78 by 6
                        hminor=1
                        regeqn;
run;
quit;
