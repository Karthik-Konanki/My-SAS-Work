  /*+----------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                         |
   |                                                                      |
   |    NAME: GMPCHORD                                                    |
   |   TITLE: GMPCHORD- Using Traditional Map Data to Produce a Drilldown |
   |                    Choropleth Map                                    |
   | PRODUCT: GRAPH                                                       |
   |  SYSTEM: ALL                                                         |
   |    KEYS: GRAPHICS MAPS GMAP CHORO TITLE ALT                          |
   |   PROCS: GMAP                                                        |
   |    DATA: MAPSSAS.US                                                  |
   |                                                                      |
   | SUPPORT: GRAPHICS STAFF                           UPDATED: 18MAY2020 |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                         |
   +----------------------------------------------------------------------+*/

    /* Get the 2020 population data for NC, SC, and VA from
	   SASHELP.US_DATA. */
%let year=2020;
data population;
   year=&year;
   set sashelp.us_data;
   where statecode in ("VA" "NC" "SC");
   rename population_&year=population;
   label statename="State Name" statecode="State Code"
      population_&year="Population";
   keep statename statecode year population_&year;
run;

    /* Create the response data set MYDATA with the U.S. states to map. */
data mydata;
   format population comma12.0;
   length htmlvar $500 datatip $120;
   set population;
   datatip = 'title='||quote(
      'State:  '|| trim(statename) ||'0D'x ||
      'Population in '|| trim(left(year)) || left(':  ') ||
      trim(left(put(population,comma12.0))));
   select(statecode);
      when("VA")
         htmlvar=trim(datatip)||
         ' href="http://www.virginia.gov" target="_blank"';
      when("NC")
         htmlvar=trim(datatip)||
         ' href="http://www.nc.gov" target="_blank"';
      when("SC")
         htmlvar=trim(datatip)||
         ' href="http://www.sc.gov" target="_blank"';
      otherwise htmlvar="";
   end;
   drop datatip;
run;

    /* Sort the response data */
proc sort data=mydata out=mydata;
   by statecode statename;
run;
  
    /* Suppress the axis labels */
axis1 label=none;
axis2 label=none minor=none offset=(0,0);

    /* Set the color to highlight the state */
pattern v=solid color=cx43a2ca;

    /* Define the title for the map. */
options nobyline;
title1 "Drilldown Map: " "State of #byval(statename)";

    /* Produce the choropleth map for each state */
proc gmap data=mydata map=mapssas.us all;
   by statecode statename;
   id statecode;
   choro population / levels=1 nolegend
      coutline=black
      html=htmlvar
      des=''
      name="map01_#byval(statecode)";
run;
quit;