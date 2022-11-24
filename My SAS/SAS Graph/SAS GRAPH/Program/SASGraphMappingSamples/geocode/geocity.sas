 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOCITY                                            |
   |   TITLE: GEOCITY- U.S. City Geocoding                       |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 04MAR2015      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create the TRAINING data set */

data training (label='Selected SAS training locations in USA');
  infile datalines dlm=',';
  length city  $ 24
         state $ 2;
  input city   /* City name                         */
        state; /* Two-character postal abbreviation */
datalines;
Atlanta, GA
Bedminster, NJ
Cary, NC
Chicago, IL
Dayton, OH
Des Moines, IA
Detroit, MI
Hartford, CT
Miami, FL
Middleton, MA
Minneapolis, MN
New York, NY
Overland Park, KS
Philadelphia, PA
Phoenix, AZ
San Antonio, TX
San Francisco, CA
Seattle, WA
;
run;

/* Run the GEOCODE procedure */

proc geocode
  method=city             /* Specify geocoding method       */
  data=training           /* Input data set of cities       */
  out=geocoded_training;  /* Output data set with locations */
run;

/* Print the output data set */

proc print data=geocoded_training noobs;
run;
