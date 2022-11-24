 /*+-----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                          |
   |    NAME: SGMPGRAD                                                     |
   |   TITLE: SGMPGRAD Gradient Legend Showing 2020 US Population          |
   |                                                                       |
   |  PRODUCT: BASE                                                        |
   |  SYSTEM: ALL                                                          |
   |    KEYS: GRAPHICS CHOROMAP SGMAP GRADLEGEND                           |
   |   PROCS: SGMAP                                                        |
   |    DATA: MAPSSAS.STATES, MAPSSAS.USCENTER, SASHELP.US_DATA            |
   | RELEASE: SAS Viya 2021.1.4 and later releases                         |
   |                                                                       |
   | SUPPORT: GRAPHICS STAFF               UPDATE:  MAY 2020               |
   | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                              |
   +-----------------------------------------------------------------------+*/

/* To switch the map type, go to
     http://services.arcgisonline.com/arcgis/rest/services
   Click on the different Services, then remove "/MapServer"
   from the end of the URL.                    */

/* The CHOROMAP statement plots the X/Y variables from the
   map data set that uses unprojected latitude/longitude values */
/* Convert From RADIANS to DEGREES */
data states;
   set mapssas.states;
   if state ^in(2,15,72);
   x = -x * 45/atan(1);
   y =  y * 45/atan(1);
run;

/* data for plotting text */
data plot_data; 
   set mapssas.uscenter;
   if state ^in(2,15,72) and ocean^='Y';
   long = -long;
   statename = fipstate(state);
run;

title 'Population from 2020 US Census';
proc sgmap mapdata=states
   maprespdata=sashelp.us_data
   plotdata=plot_data;
   esrimap
      url='http://services.arcgisonline.com/arcgis/rest/services/
Canvas/World_Light_Gray_Base';
  choromap population_2020 / mapid=state density=2
     name='choro';
  text x=long y=lat text=statename /
     textattrs=(size=6pt);
  gradlegend 'choro' / title='2020 Population' extractscale;
run;