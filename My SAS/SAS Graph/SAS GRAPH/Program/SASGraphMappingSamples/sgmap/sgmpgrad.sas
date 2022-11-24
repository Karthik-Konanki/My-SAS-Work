/*+------------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                          |
   |    NAME: SGMPGRAD                                                     |
   |   TITLE: SGMPGRAD Gradient Legend Showing 2020 US Population          |
   |                                                                       |
   |  PRODUCT: BASE                                                        |
   |  SYSTEM: ALL                                                          |
   |    KEYS: GRAPHICS CHOROMAP SGMAP GRADLEGEND                           |
   |   PROCS: SGMAP                                                        |
   |    DATA: MAPSGFK.US_STATES, MAPSGFK.USCENTER, Esri Map service        |
   | RELEASE: SAS Viya 2021.1.4 and later releases                         |
   |                                                                       |
   | SUPPORT: GRAPHICS STAFF                 UPDATE:  06MAR2022            |
   | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                              |
   +---------------------------------------------------------------------+*/

/* The CHOROMAP statement plots the X (longitude) and Y (latitude) variables
   from the MAPSGFK.US_STATES data set that contains unprojected latitude
   and longitude values. */
data states;
   set mapsgfk.us_states;
   if state ^in(2,15,72);
run;

/* Create the plot data, used by the SGMAP procedure statement and the TEXT
   statement. */
data plot_data; 
   set mapsgfk.uscenter;
   if state ^in(2,15,72) and ocean^='Y';
   statename = fipstate(state);
run;

/* Assign a title to the graph. */
title 'Population from 2020 US Census';

/* Create the graph. */
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