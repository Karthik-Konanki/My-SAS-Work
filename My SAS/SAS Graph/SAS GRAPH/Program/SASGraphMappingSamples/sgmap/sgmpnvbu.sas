 /*+---------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                        |
   |    NAME: SGMPNVBU                                                   |
   |   TITLE: SGMPNVBU Nevada County Seat Populations-Bubble Plot        |
   |                                                                     |
   |  PRODUCT: BASE                                                      |
   |  SYSTEM: ALL                                                        |
   |    KEYS: GRAPHICS CHOROMAP SGMAP BUBBLE OSM                         |
   |   PROCS: SGMAP                                                      |
   |    DATA: MAPSGFK.US_COUNTIES, SASHELP.ZIPCODE                       |
   |                                                                     |
   | SUPPORT: GRAPHICS STAFF   UPDATE:  APR2020                          |
   | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                            |
   +---------------------------------------------------------------------+*/

/* This example uses MAPSGFK which is available to 
    SAS users with SAS/GRAPH installed. */
/* The GEOCODE procedure is used to find the latitude and  */
/* longitudes of the cities, instead of merging datasets.           */

/* Create the county seat population response data set for bubbles.  */
data city_pop;
  length city $80;
  infile datalines dlm=',';
  state = 'NV';
  input city population;
datalines;
Fallon, 8458
Las Vegas, 623747
Minden, 3180
Elko, 20279
Goldfield, 443
Eureka, 487
Winnemucca, 7887
Battle Mountain, 3276
Pioche, 911
Yerington, 3064
Hawthorne, 3095
Tonopah, 2360
Lovelock, 1878
Virginia City, 717
Reno, 241445
Ely, 4134
Carson City, 54521
;
run;

/* Determine city locations of the county seats. */
proc geocode method=city
   data=city_pop
   out=city_pop (rename=(x=long y=lat))
   lookupcity=sashelp.zipcode; /* Use this if you don't have SAS GRAPH */
run;

/* Retrieve the Nevada county boundaries for the choropleth map. */
data nevada;
   set mapsgfk.us_counties(where=(statecode='NV'));
run;

/* Generate the title, map, and the legend. */
title 'Nevada County Seat Populations';
proc sgmap mapdata=nevada     /* Map boundaries */
           plotdata=city_pop  /* Bubble response & location data */
           des='Nevada';
   openstreetmap;
   choromap / mapid=county lineattrs=(color=blue) legendlabel='Counties';
   bubble x=long y=lat size=population /
      datalabel=city legendlabel='City Population'
      datalabelattrs=(family="Albany AMT" color=darkred size=9);
run;
