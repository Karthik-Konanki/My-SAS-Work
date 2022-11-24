/*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GBLPOWER                                          |
   |   TITLE: GBLPOWER-Subgroups, Multiple Plots, Data Tips      |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GBARLINE                                  |
   |   PROCS: GBARLINE                                           |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: MAR 15         |
   | SUPPORT: GRAPHICS STAFF              UPDATE: MAY 2020       |
   | updated code to run in SAS Studio [style,           |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/


/* Reset the graphics environment */
goptions reset=all border ;

ods html file="electricpowerUS.html" 
  style=dove
  gtitle nogfootnote;
title1  "US Electric Power - Revenue and Generation Sources";

footnote1  j=l italic
           link="http://www.eia.doe.gov/cneaf/electricity/epa/epat7p3.html"
           "Link to Bar Data: USEIA Energy Customer Sectors";

footnote2 j=l italic
          link="http://www.eia.doe.gov/cneaf/electricity/epa/epat1p1.html"
          "Link to Line Data: USEIA Energy Generation Sources" ;

/* Axes */
axis1 label=(j=c "Revenue" j=c "(billions)") minor=none; /* left */
axis2 label=(j=c "Power" j=c "Generated" j=c "(GWh)") minor=none; /* right */
axis3 label=none; /* bottom */

/* Legend for subgrouped bars */
legend1 position=(middle right outside)  across=1
        label=(position=(top )  j=l "Customer Sector");
/* Legend for plot lines */
legend2 position=(bottom right outside) across=1 repeat=1
        label=(position=(top) j=l  "Generation Source") ;

/* Markers for plot lines */
symbol1 c=black value=circle;
symbol2 value=dot;

proc gbarline data=sashelp.electric;
   bar year / discrete sumvar=Revenue subgroup=Customer
              raxis=axis1 maxis=axis3 legend=legend1
              html=revtip
              des="Chart of US Electricity Generation Sources and Consumers";

   plot / sumvar=AllPower   html=alltip legend=legend2 axis=axis2;
   plot / sumvar=Coal       html=coaltip;
   plot / sumvar=Nuclear    html=nuketip;
   plot / sumvar=NaturalGas html=gastip;
   plot / sumvar=Hydro      html=hydrotip;
   plot / sumvar=Other      html=othertip;
run;
quit;

ods html close;
goptions reset=all;

