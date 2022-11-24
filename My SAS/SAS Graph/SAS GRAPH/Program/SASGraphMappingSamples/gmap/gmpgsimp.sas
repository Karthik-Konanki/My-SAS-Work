/*+---------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                 |
   |                                                              |
   |    NAME: GMPGSIMP                                            |
   |   TITLE: GMPGSIMP-Using GfK GeoMarketing Map Data to Produce |
   |                   a Simple Block Map                         |
   | PRODUCT: GRAPH                                               |
   |  SYSTEM: ALL                                                 |
   |    KEYS: GRAPHICS MAPS GMAP RESOLUTION LEGEND MAPSGFK PATTERN|
   |   PROCS: GMAP                                                |
   |    DATA: MAPSGFK.ASIA, SASHELP.DEMOGRAPHICS                  |
   |                                                              |
   | SUPPORT: GRAPHICS STAFF              UPDATED: 17APR2019      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                 |
   +--------------------------------------------------------------+*/

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

   /* Define the title, legend, footnote, and color for the map */
title1 "Population in Asia";
legend1 label=(position=top) shape=bar(.3in,.1in);
footnote1 j=r "This map drawn with GfK map data";
pattern1 value=msolid color=tan;

   /* Display the block map */
proc gmap data=demographics(where=(cont=95))
   map=mapsgfk.asia resolution=4 all;
   id iso;
   block pop / blocksize=1 relzero coutline=gray legend=legend1;
run;
quit;
