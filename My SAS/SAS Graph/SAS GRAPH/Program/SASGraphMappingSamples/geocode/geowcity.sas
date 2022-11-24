 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOWCITY                                           |
   |   TITLE: GEOWCITY- World City Geocoding                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE                                            |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              NEW: 04MAR2015         |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

/* Create the CITIES data set */

data cities (label='International cities');
  infile datalines dlm=',';
  length city $32 province $24 countryID $3;
  input city        /* City name                    */
        province    /* State/province/district name */
        countryID;  /* Three-character country code */
datalines;
Bella Vista, , ARG
Bella Vista, Corrientes, ARG
Adelaide, , AUS
Quebec, Quebec, CAN
Shanghai, , CHN
Skanderborg, , DNK
Barcelona, , ESP
Tallinn, , EST
Glasgow, , GBR
Pune, , IND
Dublin, , IRL
Seoul, , KOR
Luxembourg, , LUX
Vilnius, , LTU
Garza Garcia, , MEX
Bratislava, , SVK
Stockholm, , SWE
Bangkok, , THA
Houston, Texas, USA
Johannesburg, , ZAF
;
run;

/* Run the GEOCODE procedure, ------------------------------+
|   Specify geocoding method,                               |
|   Input data set of cities,                               |
|   Output data set of locations,                           |
|   City name,                                              |
|   ADDRESSCOUNTRYVAR= required for international geocoding,|
|   Optional state or province or district name,            |
+---Values to assign to geocoded cities -------------------*/

proc geocode
   method=city
   data=cities
   out=geocoded_cities
   addresscityvar=city
   addresscountryvar=countryID
   addressstatevar=province
   attributevar=(isoname mapidname1);
run;

/* Print the output data set  */

proc print data=geocoded_cities noobs;
run;
