 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOZIPUK                                           |
   |   TITLE: GEOZIPUK-British Postcode Geocoding                |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATED: 04MAY2020     |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* The LIBNAME statement assigns the library name LOOKUP to the    */
/* location where the Bristish postcodeslookup data resides.       */
/* You must edit the 'file-path' in the following LIBNAME statement*/
/* to reference the lookup data location path designated by your   */
/* installation.                                       |           */

libname lookup 'file-path';

/* Create the OFFICES data set */

data offices;
  infile datalines dlm=',';
  length name city $24 postcode $8 country $2;
  input name                           /* Office name              */
        city                           /* Name of city             */
        postcode                       /* Royal Mail postcode      */
        country;                       /* Two-character country ID */
  postcode=upcase(compress(postcode)); /* Normalize postcodes      */
datalines;
Quay Plaza, Manchester, M50 3BA, UK
Wittington House, Buckinghamshire, SL7 2EB, UK
Tara House, Glasgow, G2 1HG, UK
New Broad Street, London, EC2M 1NH, UK
;
run;

/* Run the GEOCODE procedure */

proc geocode               /* Invoke geocoding procedure            */
   method=zip              /* Specify geocoding method              */
   data=work.offices       /* Input data set of offices             */
   out=geocoded_offices    /* Output data set of locations          */
   lookup=lookup.postcodes /* Postcode lookup data from MapsOnline  */
   addresszipvar=postcode  /* Postcode variable in input data       */
   lookupzipvar=pc         /* Postcode variable in lookup data      */
   attributevar=(Y_dms     /* Additional variables from lookup data */
                 X_dms);   /* set to assign to geocoded locations   */
run;

/* Print the output data set */

proc print data=geocoded_offices noobs;
run;
