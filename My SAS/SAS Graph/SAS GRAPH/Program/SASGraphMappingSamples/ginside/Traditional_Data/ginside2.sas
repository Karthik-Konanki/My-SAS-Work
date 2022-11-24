 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GINSIDE2                                            */
 /*   TITLE: GINSIDE2-Determining Values by Using the GINSIDE    */
 /*          PROCEDURE                                           */
 /* PRODUCT: GRAPH                                               */
 /*  SYSTEM: ALL                                                 */
 /*    PROC: GINSIDE                                             */
 /*    DATA: MAPSSAS.COUNTIES                                    */
 /*                                                              */
 /* SUPPORT: GRAPHICS STAFF              UPDATE: 06MAY2020       */
 /*     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                 */
 /****************************************************************/


 /* Create the GPSCOUNTIES data set. The X and Y values are  */
 /* converted from degrees to radians                        */
data gpscounties;
   input longitude latitude site $;
   /* convert longitude & latitude degrees to radians, like maps.counties */
   x=longitude*arcos(-1)/180;
   x=x*(-1);
   /* convert from eastlong to westlong, like maps.counties */
   y=latitude*arcos(-1)/180;
datalines;
-77.0348 40.0454 a
-78.4437 39.1623 b
-78.4115 39.3751 c
-78.7646 40.6354 d
;
run;

 /* Determine the values of STATE and COUNTY for each data point */
proc ginside data=gpscounties map=mapssas.counties out=gpscounties;
   id state county;
run;


/* Sort and print the output data set */
proc sort data=gpscounties;
   by site;
run;

proc print data=gpscounties;
   var site state county x y;
run;
quit;
