 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPGSURF                                           |
   |   TITLE: GMPGSURF- Using GfK GeoMarketing Map Data to       |
   |                    Produce a Simple Surface Map             |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP                                 |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSGFK.SAMERICA, SASHELP.DEMOGRAPHICS             |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 08MAR2013      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/
   /* Specify the format catalog to search that has the  */
   /* predefined ISO alpha2 code.                        */
options fmtsearch=(sashelp.mapfmts);

   /* Create a table named demographics using sashelp.demographics
      as the base and changing its variables to match GfK variable types
      and lengths. This table will be used as the response data set.
      Note that the ISO variable was numeric in the original
      sashelp.demographics data but is the character variable OISO in the
      GfK map data set. The format 'ison2a' uses the country's ISO numeric
      code to output the country's ISO alpha2 code. Also note that the
      ID variable was a numeric geographic locator code (glc) in the
      original sashelp.demographics data but is represented by the
      ISOALPHA2 variable in the GfK map data set.                        */
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

   /* Define the titles and footnotes for the map */
title1 "Population Annual Growth Rate Percentage";
title2 "South America (1995-2005)";
footnote1 j=r "This map drawn with GfK map data";

   /* Display the surface map */
proc gmap map=mapsgfk.samerica data=demographics;
   id id;
   surface popagr / stat=sum;
run;
quit;
