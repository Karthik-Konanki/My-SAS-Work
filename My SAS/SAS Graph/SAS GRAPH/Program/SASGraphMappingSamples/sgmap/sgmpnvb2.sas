 /*+-----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                          |
   |    NAME: SGMPNVB2                                                     |
   |   TITLE: SGMPNVB2 Nevada County Seats and Populations-Bubble Plot     |
   |                                                                       |
   |  PRODUCT: BASE                                                        |
   |  SYSTEM: ALL                                                          |
   |    KEYS: GRAPHICS CHOROMAP SGMAP BUBBLE                               |
   |   PROCS: SGMAP                                                        |
   |    DATA: MAPSGFK.US_COUNTIES                                          |
   |                                                                       |
   | SUPPORT: GRAPHICS STAFF   UPDATE: APR2020                             |
   | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                              |
   +-----------------------------------------------------------------------+*/

/* Create population response data for city bubbles. */
data city_pop (label='Nevada County Seat Populations');
   length city $65;
   infile datalines dlm=',';
   input city population_city county;
   state='NV';
datalines;
Fallon, 8458, 1
Las Vegas, 623747, 3
Minden, 3180, 5
Elko, 20279, 7
Goldfield, 443, 9
Eureka, 487, 11
Winnemucca, 7887, 13
Battle Mountain, 3276, 15
Pioche, 911, 17
Yerington, 3064, 19
Hawthorne, 3095, 21
Tonopah, 2360 , 23
Lovelock, 1878, 27
Virginia City, 717, 29
Reno, 241445, 31
Ely, 4134, 33
Carson City, 54521, 510
;
run;

/* Determine city locations of the county seats. */
proc geocode method=city
   data=city_pop
   out=city_pop (rename=(x=long y=lat))
   lookupcity=sashelp.zipcode; /* Use this if you don't have SAS GRAPH */
run;

/* Create response data for county polygons. */
data county_pop (label='Nevada Counties');
   length county_name $55;
   infile datalines dlm=',';
   input county_name county population_county;
   statecode='NV';
   /* Add five population ranges as groups to map response data. */
   if      population_county > 100000 
           then group='Greater than 100,000';
   else if population_county > 10000  
           then group='10,000 - 100,000';
   else if population_county > 5000   
           then group='5,000 - 10,000';
   else if population_county > 1000   
           then group='1,000 - 5,000';
   else               
           group='Less than 1,000';
datalines;
Churchill, 1, 24877
Clark, 3, 2069681
Douglas, 5, 47710
Elko, 7, 52766
Esmeralda, 9, 783
Eureka, 11, 1987
Humboldt, 13, 17019
Lander, 15, 5775
Lincoln, 17, 5036
Lyon, 19, 52585
Mineral, 21, 4772
Nye, 23, 43946
Pershing, 27, 6753
Storey, 29, 3987
Washoe, 31, 446903
White Pine, 33, 10030
Carson City, 510, 54521
;
run;

/* Sort the county population response data in descending order. */
proc sort data=county_pop;
   by descending population_county;
run;

/* Retrieve county boundaries for the choropleth map. */
data nevada;
   set mapsgfk.us_counties(where=(statecode='NV'));
run;

/* Create an attribute map data set that specifies a color for each
   of the population ranges. */
data attrmap;
   input id $1  value $3-22 fillcolor $24-40;
datalines;
A Greater than 100,000 cx3182bd
A 10,000 - 100,000     cx6baed6
A 5,000 - 10,000       cx9ecae1
A 1,000 - 5,000        cxc6dbef
A Less than 1,000      cxeff3ff
;
run;

/* Set the title of the map. */
title 'Nevada County Seats and Populations';

/* Create the choropleth map and the legends. */
proc sgmap mapdata=nevada         /* Map polygon geometry            */
           maprespdata=county_pop /* Map polygon response data       */
           plotdata=city_pop      /* Bubble response & location data */
           dattrmap=attrmap;      /* Choropleth color information    */
   choromap group / mapid=county id=county name='counties' attrid=A;
   bubble x=long y=lat size=population_city / fillattrs=(color=yellow) 
                                        name='cities' datalabel=city
                                        datalabelattrs=(color=black
                                                        size=9
                                                        style=italic);
   keylegend 'counties' / title='County Population';
   keylegend 'cities'   / title='City Population';
run;