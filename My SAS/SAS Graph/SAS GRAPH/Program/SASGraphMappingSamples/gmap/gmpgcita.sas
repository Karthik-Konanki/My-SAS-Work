  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPGCITA                                                    |
   |   TITLE: GMPGCITA- Using GfK GeoMarketing Map Data to Produce a      |
   |                    Choropleth Map Annotating Cities                  |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP CHORO STATISTIC GPROJECT                 |
   |   PROCS: GMAP, GPROJECT                                              |
   |    DATA: MAPSGFK.AUSTRIA, MAPSGFK.WORLD_CITIES                       |
   | RELEASE: SAS Viya 2020.1.1 and later releases                        |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           UPDATED: 16DEC2020 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/

    /* Specify the countries to map */
data all;
   length name $18;
   set mapsgfk.austria(in=k1) mapsgfk.czech_republic(in=k2)
      mapsgfk.hungary;
   if k1 then name='Austria';
   else
      if k2 then name='Czech Republic';
      else name='Hungary';
run;

    /* Project the map and store the projection parameters */

proc gproject data=all out=map degrees latlong eastlong parmout;
   id name id;
run;

    /* Create the CITIES data set specifying cities to label (annotate) */
data cities;
   set mapsgfk.world_cities(where=(pop_range_min>50000 and
      isoname in:('Austria' 'Czech' 'Hung')));
run;

   /* Project the annotation data set using the projection
      parameters stored in the prior map projection        */

proc gproject data=cities out=cities latlong eastlong degrees 
   parmin=projparm parmentry=map dupok;
   id;
run;

   /* Add annotate variables to the CITIES data set */
data anno_cities; 
   length color $15 text $55 color $15 style $18; 
   retain function 'label' xsys ysys '2' hsys '3' when 'a'; 
   set cities; 
   text='V'; 
   style='marker'; 
   color='darkslategrey'; 
   size=2.8; 
   position='5'; 
   output; 
   text='  '||trim(left(city)); 
   position='2';
   size=3; 
   style='Albany AMT/Bold'; 
   color='darkslategrey'; 
   if city in ('Gyor' 'Liberec' 'Ostrav') then position='E';
   if city eq ('Olomouc') then position='1';
   if city in ('Inns' 'Szek' 'Kecs' 'Salz') then position='6';
   if city eq 'Miskolc' then position='D';
   output;
run;

   /* Set the graphics environment */
goptions reset=all border;

   /* Define the title, footnote, and legend for the map */
title1 "Annotating Cities";
footnote j=r "This map drawn with GfK map data";
legend1 label=("Country Name:");

   /* Display the choropleth map combining 3 European countries */
proc gmap data=map map=map anno=anno_cities;
   id id;
   choro name / coutline=grayC0
                des='' 
                name='eursub' 
                stat=first
                legend=legend1;
run;
quit;