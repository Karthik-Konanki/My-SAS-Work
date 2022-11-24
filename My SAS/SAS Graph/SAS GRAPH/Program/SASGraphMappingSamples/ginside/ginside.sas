 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GINSIDE                                             */
 /*   TITLE: GINSIDE-Determine which points lie outside a map.   */
 /* PRODUCT: GRAPH                                               */
 /*  SYSTEM: ALL                                                 */
 /*    PROC: GINSIDE                                             */
 /*    DATA: MAPSGFK.US_COUNTIES                                 */
 /*                                                              */
 /* SUPPORT: GRAPHICS STAFF              UPDATE: 24APR2020       */
 /*     REF: SAS/GRAPH & Base SAS MAPPING REFERENCE              */
 /*    MISC: Determine which customers are inside Wake County.   */
 /*          Draw a map and color the X's red to                 */
 /*          illustrate the customers outside the county.        */
 /****************************************************************/

 /* Create the CUSTOMERS data set  */

data customers;
length name $20;
input lat long name;
datalines;
35.77 -78.67 Smith
35.83 -78.84 Jones
35.77 -78.78 Doe
35.64 -78.46 Patel
36.01 -78.89 White
35.97 -78.52 Short
35.78 -78.36 Phillips
35.82 -78.31 Jackson
;
run;

 /* Create the MYMAP data set with one specific county */
data mymap;
set mapsgfk.us_counties(where=(fipstate(state)='NC'
                        and county=183));
run;

 /* Project the map */
proc gproject data=mymap
              out=mymap
              latlong
              eastlong
              degrees
              dupok
              parmout=projparm;
id state county;
run;

/* Project the point-data, using the same parameters */
proc gproject data=customers out=customers
     latlong eastlong degrees dupok
     parmin=projparm parmentry=mymap;
id;
run;

/* GINSIDE processes X/Y variables, therefore run it after */
/* GPROJECT (otherwise you must rename the long/lat   */
/* variables to X/Y).                                  */

 /* Determine which customer points fall inside or outside
   of the county  */
 /* GINSIDE can be run before or after the GPROJECT procedure */
proc ginside map=mymap data=customers out=customers;
  id state county;
run;

 /* Print the resulting data with certain variables */
title "If the state & county have a value,
        the coordinate is 'inside' the county";
proc print data=customers;
 var lat long name state county;
run;

 /* Add annotations to the CUSTOMERS data set */
data customers;
   set customers;
   length color style $8;
   retain xsys ysys '2' hsys '3' when 'a' position '5' size 5;
   style='marker';
   if missing(county) then do;
     color='red';
     text='X';
     end;
   else do;
     color='green';
     text='U';       /* Marker font for a square */
     end;
   output;
   style='markere';  /* outline the symbols */
   color='gray33';
   output;
 run;

 /* Define the title and map color for the graph */
title 'X Represents Customers Outside Wake County';
pattern1 v=s c=graydd;

 /* Create the choropleth map and annotate with */
 /* the variables in the CUSTOMERS data set    */
proc gmap data=mymap map=mymap anno=customers;
  id state county;
  choro county / stat=sum coutline=black nolegend;
run;
quit;
