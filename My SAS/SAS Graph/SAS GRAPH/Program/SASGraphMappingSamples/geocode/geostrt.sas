 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GEOSTRT
   |   TITLE: GEOSTRT- Street Geocoding                          |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GEOCODE                              |
   |   PROCS: GEOCODE PRINT                                      |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 19OCT2016      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   |   TABLE: csgeoG, csgeoL                                     |
   |                                                             |
   | HISTORY:                                                    |
   |   DATE      USERID REASON                                   |
   |   20Jul2012 kelmil pushed new test from sample              |
   |   18Sep2012 kelmil updates from S0898674                    |
   |   20Sep2012 andenn removed data line for S0898674           |
   |   06Mar2013 andenn updated comment line verbiage (state,zip)|
   |   04Mar2015 andenn removed quit; per customer request       |
   |   19Oct2016 andenn updated to illustrate TYPE= for gctype   |
   +-------------------------------------------------------------+*/

/*Create the input data set.*/
data WORK.CUSTOMERS (label='Input data for street geocoding');
  infile datalines dlm='#';
  length address $ 32
         city    $ 24
         state   $ 2;
  input address          /* House number and street name      */
        zip              /* Customer ZIP code (numeric)       */
        city             /* City name                         */
        state;           /* Two-character postal abbreviation */
datalines;
555 Junk Street # 99999 # Beverly Hills # CA
305 Cross Lake Drive # 27526 # Fuquay-Varina # NC
2525 Banks Road # 27603 # Raleigh # NC
2222 SAS Campus Drive # 27513 # Cary # NC
1150 SE Maynard Rd. # 27511 # Cary # NC
2117 Graceland # 27606 # Raleigh # NC
1313 Mockingbird Lane # # Delray # CC
133 Jade Circle # 27545 # Knightdale # NC
1005 W South St # 27603 # Raleigh # NC
622 Roundabout Road # 27540 # Holly Springs # NC
Johnson Family Rd # 27526 # #
822 Water Plant Road # # Zebulon # NC
502 Possum Track Road # 27614 # # NC
2590 Wolfpack Lane # 27604 # Raleigh # NC
125 Ferris Wheel Ct # 27513 # Cary # NC
3900 Western Blv # 27606 # Raleigh # NC
;
run;

/* Create custom street type data set which includes the non-standard
   abbreviation for 'BOULEVARD' used in the input data. */
data work.gctype;
  set sashelp.gctype;
  output;
  /* Insert non-standard type. */
  if _n_ = 1 then do;
    name  = 'BLV';
    type  = 'BLVD';
    group = 34; /* group number must match other 'BLVD' types */
    output;
  end;
run;
/* Sort the custom gctype dataset */
proc sort data=work.gctype;
  by name;
run;

/* Geocode the data and then print the output data set.                */
  proc geocode                    /* Invoke geocoding procedure        */
      method=STREET               /* Specify geocoding method          */
      data=WORK.CUSTOMERS         /* Input data set of addresses       */
      out=WORK.GEOCODED           /* Output data set with X/Y values   */
      lookupstreet=SASHELP.GEOEXM /* Primary street lookup data set    */
      type=WORK.GCTYPE;           /* Lookup data set-added street type */
run;

proc print data=WORK.GEOCODED noobs;
   var address m_addr m_zip m_obs _matched_ _status_
               _notes_ _score_ x y;
run;
