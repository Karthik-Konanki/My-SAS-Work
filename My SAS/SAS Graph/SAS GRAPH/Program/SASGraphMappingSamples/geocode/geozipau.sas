 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOZIPAU                                           |
   |   TITLE: GEOZIPAU-Australian Postcode Geocoding             |
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
location where the Australian postcodelookup data is installed.
You must edit the 'file-path' in the following LIBNAME statement
to reference the lookup data location path designated by your 
installation */

libname lookup 'file-path';

/* Create the STADIUMS data set */

data stadiums (label='Australian National Rugby League (NRL) stadiums');
  infile datalines dlm=',';
  length team $32 stadium $32 city $ 24 state $32 postcode $4;
  input team        /* NRL team name    */
        stadium     /* Stadium name     */
        city        /* City name        */
        state       /* State name       */
        postcode;   /* Stadium postcode */
datalines;
South Sydney Rabbitohs, ANZ Stadium, Sydney, New South Wales, 2127
Sydney Roosters, Sydney Football Stadium, Moore Park, New South Wales, 2021
Canterbury Bulldogs, ANZ Stadium, Sydney, New South Wales, 2127
Parramatta Eels, Parramatta Stadium, Sydney, New South Wales, 2150
Manly-Warringah Sea Eagles, Brookvale Oval, Brookvale, New South Wales, 2100
Cronulla-Sutherland Sharks, Toyota Park, Woolooware, New South Wales, 2230
Penrith Panthers, Centrebet Stadium, Penrith, New South Wales, 2750
Canberra Raiders, Canberra Stadium, Bruce, Australian Capital Territory, 2617
Brisbane Broncos, Suncorp Stadium, Milton, Queensland, 4064
Newcastle Knights, Hunter Stadium, New Castle, New South Wales, 2292
North Queensland Cowboys, Dairy Farmers Stadium, Townsville, Queensland, 4817
Melbourne Storm, AAMI Park, Melbourne, Victoria, 3000
St. George Illawarra Dragons, WIN Jubilee Oval, Carlton, New South Wales, 2217
Wests Tigers, Campbelltown Stadium, Leumeah, New South Wales, 2560
Wests Tigers, Leichhardt Oval, Leichhardt, New South Wales, 2040
Wests Tigers, Sydney Football Stadium, Sydney, New South Wales, 2021
Gold Coast Titans, Skilled Park, Gold Coast, Queensland, 4226
;
run;

/* Run the GEOCODE procedure */

proc geocode              /* Invoke geocoding procedure       */
  method=zip              /* Specify geocoding method         */
  data=stadiums           /* Input data of stadiums           */
  out=geocoded_stadiums   /* Output data set of locations     */
  lookup=lookup.postcodes /* Lookup data with postcodes       */
  addresszipvar=postcode  /* Postcode variable in input data  */
  lookupzipvar=poa_code;  /* Postcode variable in lookup data */
run;

/* Print the output data set */

proc print data=geocoded_stadiums noobs;
run;
