 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GINSIDE2                                            */
 /*   TITLE: GINSIDE2-Determining Values by Using the GINSIDE    */
 /*          PROCEDURE                                           */
 /* PRODUCT: GRAPH                                               */
 /*  SYSTEM: ALL                                                 */
 /*    PROC: GINSIDE                                             */
 /*    DATA: MAPSGFK.US_COUNTIES                                 */
 /*                                                              */
 /* SUPPORT: GRAPHICS STAFF              UPDATE: 06MAR2022       */
 /*     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                 */
 /****************************************************************/

/* Get the unprojected US county coordinates from
   MAPSGFK.US_COUNTIES. */
data us_counties;
   set mapsgfk.us_all;
   keep segment state county lat long density;
   rename long=x lat=y;
run;

/* Create the GPSCOUNTIES data set. */
data gpscounties;
   input x y site $;
datalines;
-77.0348 40.0454 a
-78.4437 39.1623 b
-78.4115 39.3751 c
-78.7646 40.6354 d
;
run;

/* Determine the values of STATE and COUNTY for each data point.
   Add the values to the created data set. */
proc ginside data=gpscounties map=us_counties out=gpscounties;
   id state county;
run;

/* Sort and print the output data set. */
proc sort data=gpscounties;
   by site;
run;

proc print data=gpscounties;
   var site state county x y;
run;
quit;