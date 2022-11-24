 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOZIP4                                            |
   |   TITLE: GEOZIP4- ZIP+4 Geocoding                           |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              NEW: 04MAY2020         |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* The LIBNAME statement assigns the library name LOOKUP to the
location where the ZIP+4 lookup data is installed.
You must edit the 'file-path' in the following LIBNAME statement
to reference the lookup data location path designated by your 
installation */

libname lookup 'file-path';

/* Create the CUSTOMERS data set */

data customers;
   infile datalines dlm=',';
   length name city $32 state $2;
   input name      /* Customer name      */
         zip       /* Customer ZIP Code  */
         plus4     /* ZIP+4              */
         city      /* City name          */
         state;    /* State abbreviation */
datalines;
J. Cheever Loophole, 27603, 2681, Raleigh, NC
Cuthbert J. Twillie, 77450, 3418, Katy, TX
Kaspar Gutman, 19808, 1927, Wilmington, DE
Dr. Hugo Z. Hackenbush, 19363, 1735, Oxford, PA
Charlie Allnut, 28365, 2277, Mount Olive, NC
Larson E. Whipsnade, 19963, 1941, Milford, DE
Guillermo Ugarte, ., 2208, Bradenton, FL
Capt. Geoffrey Spaulding, 19975, 7504, Selbyville, DE
Joel Cairo, 19944, 4401, Fenwick Island, DE
Charles Blutoski, 19953, 3141, Hartly, DE
Rufus T. Firefly, ., ., Wimberley, TX
Otis B. Driftwood, 19955, 53, Kenton, ,
Gordon Miller, 21921, 5335, Elkton, MD
;
run;

/* Run the GEOCODE procedure */

proc geocode           /* Invoke geocoding procedure  */
     method=plus4             /* Specify geocoding method    */
     lookup=lookup.zip4       /* Lookup data from MapsOnline */
     data=customers           /* Input data set to geocode   */
     out=geocoded_customers;  /* Specify name of Output data set of locations */
run;

/* Print the output data set */

proc print data=geocoded_customers noobs;
run;
