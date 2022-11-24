 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GMPGCHAN                                           |
   |   TITLE: GMPGCHAN-Using GfK GeoMarketing Map Data to Produce|
   |                   a Choropleth County Map Annotating Roads  |
   |                   and Water                                 |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS GMAP ANNOTATE MAPIMPORT MAPSGFK      |
   |   PROCS: GMAP                                               |
   |    DATA: MAPSGFK.US_COUNTIES                                |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 19OCT2016      |
   |     REF: SAS/GRAPH & BASE MAPPING REF. GUIDE                |
   +-------------------------------------------------------------+*/

   /* Specify the path to the shape file that you downloaded   */
   /* from the U.S. Census Bureau TIGER website. An example    */
   /* shapefile name is "tl_2012_37183_edges.shp." Specify     */
   /* attributes of the map such as map dimensions, colors,    */
   /* and label font. */
%let shapefilepath=path-to-shapefile;
%let mapwidth=600;  /* Pixels */
%let mapheight=450; /* Pixels */
%let majroadcolor=firebrick;
%let secroadcolor=gray;
%let watercolor=skyblue;
%let pointcolor=yellow;
%let pointoutlinecolor=brown;
%let pointsize=.6;
%let labelfont=Albany AMT;

   /* Set the graphics environment */
goptions border device=svg xpixels=&mapwidth ypixels=&mapheight;
options svgheight="&mapheight.px" svgwidth="&mapwidth.px"
   papersize=("%sysfunc(cat(&mapwidth/96, in))",
   "%sysfunc(cat(&mapheight/96, in))");

   /* Subset Wake County in the state of North Carolina from
      the GfK map data.                                        */
data ncwake;
   length dsn $8;
   set mapsgfk.us_counties(where=(fipstate(state)="NC" and county=183));
   x=long;
   y=lat;
   dsn="map";
run;

   /* Use the MAPIMPORT procedure to produce an output map data */
   /* set from data that you downloaded from the                */
   /* U.S. Census Bureau's TIGER website. Macro variable        */
   /* shapefilepath contains the path to the shape file.        */
proc mapimport datafile="&shapefilepath"
   out=work.wake;
run;

   /* Keep the primary and secondary roads and the  */
   /* water lines from the downloaded data          */
data roads;
   set work.wake(where=(mtfcc in:('S1100' 'S1200' 'H')));
run;

   /* Optional step. Remove comments if you want to run this. */
   /* Running the GINSIDE procedure is only necessary if the  */
   /* annotate step that is run next results in               */
   /* observation mapping errors.                             */
/*
proc ginside map=ncwake data=roads out=rdsinwake insideonly;
   id id;
run;
*/

   /* Create an annotate data set so that the roads and
      fishing areas can be displayed on top of the map.  */

data annor(drop=statefp countyfp);
   length STATE COUNTY 5 text color $15;
   retain xsys ysys "2" when "A";
   /*set rdsinwake;*/ /* Uncomment this if you run the GINSIDE proc.*/
   set roads; /* Comment out this data set if you run GINSIDE proc.*/
   dsn="lines";
   /* Define SAS variables: SAS data sets have */
   /* state and county defined as numeric     */
   STATE=statefp; county=countyfp;
   id="US-"||put(state,z2.)||put(county,z3.);
   LONG=X;  LAT=Y;
   by TLID notsorted;
   text=mtfcc;
   if mtfcc="S1100" then do; line=3; color="&majroadcolor"; size=2; end;
   else if mtfcc="S1200" then do; line=2; color="&secroadcolor";end;
        else if mtfcc=:"H" then do; line=4; color="&watercolor"; end;
   if first.TLID then do;
      function="MOVE";
      output;
   end;
   else do;
      function="DRAW";
      output;
  end;
run;

   /* Create the data set WORK.WRC_FISHING that contains the 
      NC fishing areas.                                      */ 
data WORK.WRC_FISHING; 
   infile cards dsd; 
   input X Y Fishing_Area_Name : $25. 
          FishingPier 
          ShorelineAccess 
          BoatRamp 
          CanoeAccess 
          UniveralAccess 
          WaterbodyName : $32.; 
datalines; 
-78.5392,35.7987,NEUSE RIVER EAST,0,1,0,1,0,NEUSE RIVER 
-78.6275,35.9791,OLD 98,0,1,0,0,0,FALLS RESERVOIR 
-78.6540,35.9705,UPPER BARTON CREEK,0,1,0,1,0
FALLS RESERVOIR
-78.7226,36.0536,LEDGE ROCK,.,0,1,0,0,FALLS RESERVOIR 
-78.6843,36.0342,BEAVERDAM,0,1,1,1,0,FALLS RESERVOIR 
-78.6915,36.0215,HWY 50,0,1,1,1,0,FALLS RESERVOIR 
-78.8166,35.7468,APEX COMMUNITY PARK,1,1,0,1,0,PINE LAKE 
-78.8042,35.6429,BASS LAKE PARK,1,1,0,1,0,BASS LAKE PARK 
-78.9390,35.6086,HOLLEMANS CROSSING,.,0,1,0,0
SHEARON HARRIS RESERVOIR
-78.6957,35.6972,SIMPKINS POND,0,1,0,0,0
SIMPKINS POND / LAKE WHEELER
-78.6635,35.8585,SHELLEY LAKE,1,1,1,1,1,SHELLEY LAKE 
-78.6775,35.7668,LAKE RALEIGH,1,1,0,1,1,LAKE RALEIGH 
-78.7907,35.8384,LAKE CRABTREE COUNTY PARK,1,1,1,1,1
LAKE CRABREE COUNTY PARK
-78.7137,35.7627,LAKE JOHNSON PARK,1,0,0,1,0
LAKE JOHNSON
-78.9259,35.6258,HARRIS LAKE PARK,1,1,0,1,0
HARRIS LAKE & HARRIS PARK POND
-78.8259,35.7812,FRED G BOND METRO PARK,1,1,0,1,0
BOND PARK POND
;
run;

   /* Add the annotate variables.  */
data wrc;
   length STATE 5 COUNTY 5 text $45 font $8 color $8 style $18
      function $8 dsn $8;
   retain STATE 37 COUNTY 183 xsys ysys "2" when "A" 
      font "marker";
   set wrc_fishing;
   dsn="points";
   text=fishing_area_name;
   style="&labelfont/bold";
   size=1;
   function="label"; 
   position="<";
   /* reposition overlapping and crowded labels */
   if text in("LAKE RALEIGH" "OLD 98" "HWY 50"
      "HOLLEMANS CROSSING" "SHELLEY LAKE" "BASS LAKE PARK")
      then position=">";
   output;
   function="pie";
   rotate=360;
   style="psolid";
   color="&pointcolor";
   position="5";
   size=&pointsize;
   output;
   /* Draw a dark ring around pie, to help */
   /* distinguish overlapping ones         */
   style="pempty"; 
   color="&pointoutlinecolor";
   line=1;
   html=" ";
   output;
run;

   /* Combine the map, roads, and fishing area */
   /* data sets so that they can be projected  */
   /* together.                                */

data all;
   length function $8 text $45 style $20;
   set ncwake annor wrc;
run;

proc gproject data=all out=prj degrees eastlong dupok;
   id dsn id;
run;

   /* Separate the map and the annotate data sets. */
data map lines points;
   set prj;
   if dsn="map" then output map;
   else if dsn="lines" then output lines;
        else output points;
run;

   /* Create an annotation data set that includes POINTS
      and annotation instructions for a map legend. */
data choroanno;
   set points end=last;
   if (last) then do;
      output;
      color="black"; ysys=1; xsys=1; line=1; size=2;
      function="move"; x=75; y=10; output;
      color="&majroadcolor"; function="draw"; x=90; y=10; output;
      function="move"; x=75; y=7; output;
      color="&secroadcolor"; function="draw"; x=90; y=7; output;
      function="move"; x=75; y=4; output;
      color="&watercolor"; function="draw"; x=90; y=4; output;
      size=1.2; color="black"; position='>'; style="&labelfont";
      x=92; y=10; function="label"; text="Major Roads"; output;
      x=92; y=7; function="label"; text="Secondary Roads"; output;
      x=92; y=4; function="label"; text="Water"; output;
   end;
   else output;
   keep x y function text style color xsys ysys when
      line size font position rotate;
run;

   /* Display the choropleth map */
proc gmap map=map data=map anno=lines;
   id id;
   choro state/discrete nolegend anno=choroanno stat=sum;
   pattern v=s r=100 color=whitesmoke;
   title1 height=2 "Fishing areas in Wake County, NC";
run;
quit;

   /* Reset system options SVGWIDTH=, SVGHEIGHT=, and 
      PAPERSIZE= to their default values.             */
options svgheight="" svgwidth=""
   %sysfunc(getoption(papersize,keyword,defaultvalue));
