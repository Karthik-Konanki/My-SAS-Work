/*+-----------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                    |
  |    NAME: SGMPBUSE                                               |
  |   TITLE: SGMPBUSE Series Plot of Hurricane Katrina's Path       |
  |                                                                 |
  |  PRODUCT: BASE                                                  |
  |  SYSTEM: ALL                                                    |
  |    KEYS: GRAPHICS BUBBLE SGMAP SERIES OSM                       |
  |   PROCS: SGMAP                                                  |
  |    DATA: INTERNAL                                               |
  |                                                                 |
  | SUPPORT: GRAPHICS STAFF                  UPDATE: APR2020        |
  | REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                        |
  +-----------------------------------------------------------------+*/

/* Create hurricane location response data for the series lines and
   wind speed for the bubbles. */
data katrina;
   format datetime datetime18.;
   informat datetime datetime18.;
   infile datalines dlm=',';
   input datetime lat long wind;
   datestring=substr(put(datepart(datetime),date9.),1,5);
datalines;
23AUG2005:18:00:00,23.1,-75.1,30
24AUG2005:06:00:00,23.8,-76.2,30
25AUG2005:06:00:00,26.1,-78.4,50
26AUG2005:06:00:00,25.4,-81.3,65
27AUG2005:06:00:00,24.4,-84,95
28AUG2005:06:00:00,25.2,-86.7,125
29AUG2005:06:00:00,28.2,-89.6,125
30AUG2005:06:00:00,34.1,-88.6,40
31AUG2005:06:00:00,40.1,-82.9,25
;
run;

/* Set the title for the graph. */
title1 'Hurricane Katrina (2005)';

/* Create the OpenStreetMap and plot overlays. */
proc sgmap plotdata=katrina;
   openstreetmap;
   series x=long y=lat / 
      lineattrs=(color=red thickness=2)
      legendlabel='Storm Track';
   bubble x=long y=lat size=wind /
      fillattrs=(color=blue transparency=.9)
      datalabel=datestring datalabelpos=left
      datalabelattrs=(color=red size=10)
      legendlabel='Relative Wind Speed';
run;
