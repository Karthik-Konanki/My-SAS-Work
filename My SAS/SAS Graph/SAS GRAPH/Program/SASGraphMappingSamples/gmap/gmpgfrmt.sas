 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPGFRMT                                           |
   |   TITLE: GMPGFRMT-Using GfK GeoMarketing Map Data to Assign |
   |                   a Format to the Response Variable         |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP PATTERN LEGEND                  |
   |   PROCS: GMAP SORT                                          |
   |    DATA: MAPSGFK.ASIA, SASHELP.DEMOGRAPHICS                 |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 04MAR2013      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Specify the format catalog to search that has the  */
   /* predefined ISO alpha2 code.                        */
options fmtsearch=(sashelp.mapfmts);

  /* Create a table named demographics using sashelp.demographics */
  /* as the base and change its variables to match GfK variable types and */
  /* lengths. This table is used as the response data set. This */
  /* step makes two changes to the sashelp.demographics data set. */
  /* The ISO variable is converted from numeric to character. Secondly, */
  /* a character ID variable is created. This ID value matches the character */
  /* variable ISOALPHA2 value in the GfK map data set. The format 'ison2a' */
  /* is used to convert the numeric ISO code to its equivalent */
  /* ISOALPHA2 code. */

proc sql;
   create table demographics(rename=(iso=oiso newiso=iso id=oldid newid=ID)) as
      select demo.*, 
      put(demo.iso,z3.) as newiso format=$3.,
      put(demo.iso,ison2a.) as newid 
      from sashelp.demographics as demo;
   alter table demographics
      modify ID char(15) label='Alpha2 Country Code';
run;
quit;

   /* Set the graphics environment */
goptions reset=all border;


   /* Create the format for the POP variable */
proc format;
value popfmt low-1000000="0-1"
             1000001-10000000="1-10"
             10000001-100000000="10-100"
             100000001-500000000="100-500"
             500000001-high="over 500";
run;

   /* Create the format for the REGION variable */
proc format;
value $ regionfmt "SEAR" = "South-East Asia"
                  "EUR" = "Europe"
                  "EMR" = "Eastern Mediterranean"
                  "WPR" = "Western Pacific";
run;

   /* Define the title, footnote, and colors for the map */
title1 "Population Data for Asia (2005)";
footnote j=r "This map drawn with GfK map data";
pattern1 color=gold value=msolid;
pattern2 color=yellow value=msolid;
pattern3 color=cyan value=msolid;
pattern4 color=light_blue value=msolid;

   /* Assign the legend label */
legend1 label=("Population (Millions)");

   /* Display the block map */
proc gmap data=demographics(where=(cont=95))
   map=mapsgfk.asia all;
   format pop popfmt.;
   format region $regionfmt.;
   id id;
   area region / midpoints="SEAR" "EUR" "EMR" "WPR";
   block pop / legend=legend1 relzero levels=all;
run;
quit;
