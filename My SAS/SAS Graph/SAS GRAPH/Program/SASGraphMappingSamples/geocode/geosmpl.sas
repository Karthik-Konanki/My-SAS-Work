
 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOSMPL                                            |
   |   TITLE: GEOSMPL- Geocoding Using Default Values            |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 04MAR2015      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create the CUSTOMERS data set */

data CUSTOMERS (label="Customer data for geocoding");
infile datalines dlm='#';
length address $ 24 city $ 24 state $ 2;
input address    /* House number and street name */
      zip        /* Customer ZIP code (numeric)  */
      city       /* City name                    */
      state      /* State abbreviation           */
;
cust_ID = _n_;   /* Assign customer ID number    */
datalines;
555 Junk Street # 99999 # Beverly Hills # CA
115 E. Water St # 19901 # Dover #
760 Moose Lodge Road # 19934 # Camden #
200 S. Madison Str # 19801 # Wilmington # DE
4701 Limestone Road # 19808 # Wilmington #
2117 N 4th St # 19363 # Oxford # PA
1313 Mockingbird Lane # . # Delray # CC
133 Silver Lake Dr # 19971 # Rehoboth Beach # DE
11 SE Front Street # 19963 # Milford # DE
402 Nylon Boulevard # . # Seaford # DE
363 E Commerce St # . # Smyrna # DE
5595 Polly Branch Rd # 19975 # Selbyville # DE
1209 Coastal Highway # 19944 # Fenwick Island # DE
2899 Arthursville Rd # 19953 # Hartly # DE
41 Bramhall St # . #  #
9320 Old Racetrack Rd # . # Delmar # DE
281 W Commerce Str # 19955 # Kenton #
211 Blue Ball Road # 21921 # Elkton # MD
3893 Turkey Point Rd # 19980 # Woodside # DE
;
run;

/* Run the GEOCODE procedure with the default ZIP method */

proc geocode out=geocoded_customers;
run;

/* Print the output data set*/
proc print data=geocoded_customers noobs;
run;
