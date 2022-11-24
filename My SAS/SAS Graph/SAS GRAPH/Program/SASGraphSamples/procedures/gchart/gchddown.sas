
 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GCHDDOWN                                           |
   |   TITLE: GCHDDOWN-Creating Drill-down Bar Charts for the Web|
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS AXIS GCHART ODS                           |
   |   PROCS: FORMAT GCHART                                      |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 27MAR2015      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC: FOR CMS, CHANGE FILENAME SPECIFICATIONS FOR        |
   |          ODS STATEMENTS                                     |
   |                                                             |
   |          USE grain_frame.html TO SEE THE RESULTS IN YOUR    |
   |          BROWSER                                            |
   +-------------------------------------------------------------+*/

/******************* Part A **********************/

/* Define a fileref for the output. */
filename odsout ".";

/* Set selected graphics options for the examples. */
goptions reset=all xpixels=550 ypixels=500
   cback=white;

/* Create the data set GRAINLDR. */
data grainldr;
   length country $ 3 type $ 5;
   input year country $ type $ amount;
   format megtons comma5.0;
   megtons=amount/1000;
datalines;
1995 BRZ Wheat 1516
1995 BRZ Rice 11236
1995 BRZ Corn 36276
1995 CHN Wheat 102207
1995 CHN Rice 185226
1995 CHN Corn 112331
1995 IND Wheat 63007
1995 IND Rice 122372
1995 IND Corn 9800
1995 INS Wheat .
1995 INS Rice 49860
1995 INS Corn 8223
1995 USA Wheat 59494
1995 USA Rice 7888
1995 USA Corn 187300
1996 BRZ Wheat 3302
1996 BRZ Rice 10035
1996 BRZ Corn 31975
1996 CHN Wheat 109000
1996 CHN Rice 190100
1996 CHN Corn 119350
1996 IND Wheat 62620
1996 IND Rice 120012
1996 IND Corn 8660
1996 INS Wheat .
1996 INS Rice 51165
1996 INS Corn 8925
1996 USA Wheat 62099
1996 USA Rice 7771
1996 USA Corn 236064
;

/* Define the format for COUNTRY */
proc format;
   value $country
      "BRZ" = "Brazil"
      "CHN" = "China"
      "IND" = "India"
      "INS" = "Indonesia"
      "USA" = "United States";

/* Add the variables for html text and drilldown */
data newgrain;
   set grainldr;
   length yeardrill typedrill countrydrill $ 100;

   /* Assign targets for the YEAR values. */
   yeardrill=
    "TITLE="||quote(trim(left(year)))||' '||
    "HREF="||quote('year'||trim(left(year))||'_body.html');

   /* Assign targets for the COUNTRY values. */
   countrydrill=
    "TITLE="||quote(trim(left(put(country,$country.))))||' '||
    "HREF="||quote('country_body.html#'||trim(left(country)));

   /* Assign targets for the TYPE values. */
   typedrill=
    "TITLE="||quote(trim(left(type)))||' '||
    "HREF="||quote(trim(left(type))||'_body.html');


/* Define the characteristics for the legend */
legend1 label=none
   shape=bar(.15in,.15in)
   position=(bottom center);

/* Set the image format to PNG */
goptions device=png;

/* Close the currently open ODS destinations. */
ods _all_ close;

/* Specify the ODS HTML options. */
ods html body="grain_body.html"
   frame="grain_frame.html"
   contents="grain_contents.html"
   gtitle gfootnote
   style=listing
   path=odsout;

/* Suppress the midpoint label and values for individual bars */
axis1 label=none value=none;

/* Change the response axis label and rotate it 90 degrees. Suppress
   the minor tick marks. Specify the axis order as 0 to 500 in
   increments of 100. Set the offsets to zero. */
axis2 label=(angle=90 "Metric Tons (millions)")
   minor=none
   order=(0 to 500 by 100)
   offset=(0,0);

/* Suppress the group axis label and modify the group axis order.
   Let the labels wrap on a blank space, if needed. Set the
   offsets to four. */
axis3 label=none
   order=("China" "United States" "India" "Indonesia" "Brazil")
   split=" " offset=(4,4);

/* Define the titles and footnote. */
title1 ls=1.5 "Corn, Rice, and Wheat Production";
title2 "Leading Producers for 1995 and 1996";
footnote1 ls=1.3 "Click the bars or legend colors to drill down.";

/* Produce main bar chart: totals for all countries. */
proc gchart data=newgrain;
   format country $country.;
   vbar year / discrete type=sum sumvar=megtons
      group=country
      subgroup=year
      space=0
      maxis=axis1
      gaxis=axis3
      raxis=axis2
      autoref cref=graydd clipref
      legend=legend1
      html=countrydrill
      html_legend=yeardrill
      name="grainall"
      des="Overview of Leading Grain Producers";
run;
quit;


/******************** Part B *********************/

/* Produce two bar charts of year: subgroup countries by type. */

/* Modify the midpoint axis order. Let the labels wrap on a
   blank space, if needed. Set the offsets to eight. */
axis4 label=none
   order=("China" "United States" "India" "Indonesia" "Brazil")
   split=" " offset=(8,8);

/* Create macro %DO_YEAR to use for generating the year graphs */
%macro do_year(year);

/* Open the ODS HTML destination. */
ods html body="year&year._body.html"
  gtitle gfootnote
  path=odsout style=listing;

/* Define the chart title */
title1 ls=1.5 "Total Production for &year";

/* Produce the bar chart for the specified year */
proc gchart data=newgrain (where=(year=&year));
   format country $country.;
   vbar country / type=sum sumvar=megtons
      subgroup=type
      legend=legend1
      raxis=axis2
      maxis=axis4
      width=8
      autoref cref=graydd clipref
      html=countrydrill
      html_legend=typedrill
      name="year_&year"
      des="Production Breakdown for &year";
run;
quit;

%mend do_year;


/* Call macro %DO_YEAR for the years 1995 and 1996. */
%do_year(1995);
%do_year(1996);


/*********************** Part C **********************/

/* Suppress the group axis labels. Allow the labels to wrap
   on a blank space, if necessary. Set the offsets to four. */
axis5 label=none split=" " offset=(4,4);

/* Specify the range axis order as 0 to 250 in increments
   of 50. Set the offsets to zero. */
axis6 label=(angle=90 "Metric Tons (millions)")
   minor=none
   order=(0 to 250 by 50)
   offset=(0,0);

/* Open a new body for the breakdown by country. */
ods html body="country_body.html"
  gtitle gfootnote
  path=odsout style=listing ;

/* Suppress the BY-line. */
options nobyline;

/* Create macro %DO_COUNTRY to use for generating the country graphs. */
%macro do_country(country);

/* Set the anchor to the specified country */
ods html anchor="&country";

/* Define the titles. */
title1 ls=1.5 "Breakdown for #byval(country)";
title2 "(In Millions of Metric Tons)";

/* Produce the series of bar charts: country and type. */
proc gchart data=newgrain (where=(country="&country"));
   format country $country.;
   by country; /* Enables the use of #byval in title and description */
   vbar year / discrete type=sum sumvar=megtons
      group=type
      subgroup=year
      legend=legend1
      outside=sum
      space=0
      maxis=axis1
      raxis=axis6
      gaxis=axis5
      autoref cref=graydd clipref
      html=typedrill
      html_legend=yeardrill
      name="country_&country"
      des="Grain and Year Breakdown for #byval(country)";
run;
%mend do_country;

/* Call macro %DO_COUNTRY for CHN, USA, IND, INS, and BRZ */
%do_country(CHN);
%do_country(USA);
%do_country(IND);
%do_country(INS);
%do_country(BRZ);

quit;


/*********************** Part D ****************************/

/* Create macro %DO_TYPE to use for generating the type graphs. */
%macro do_type(type);
/* Open a new body for the breakdown by type */
ods html path=odsout body="&type._body.html"
  newfile=table
  gtitle gfootnote
  path=odsout style=listing;

/* Define the lower threshold for the top producers. */
%let minamount=30; /* In metric megatons */

/* Define the titles */
title1 ls=1.5 "Top Producers of &type";
title2 "(Producing &minamount Million Metric Tons or More)";

/* Produce the series of bar charts: country and type. */
proc gchart data=newgrain (where=(megtons ge &minamount and type="&type"));
   format country $country.;
   vbar year / discrete type=sum sumvar=megtons
      group=country
      subgroup=year
      legend=legend1
      outside=sum
      space=0
      maxis=axis1
      raxis=axis6
      gaxis=axis5
      autoref cref=graydd clipref
      html=countrydrill
      html_legend=yeardrill
      name="type_&type"
      des="Top &type Producers (&minamount Million Metric Tons or More)";
run;
quit;

%mend do_type;


/* Call macro %DO_TYPE for Corn, Rice, and Wheat. */
%do_type(Corn);
%do_type(Rice);
%do_type(Wheat);

/* Clear the titles and footnotes */
title;
footnote;

/* Close ODS HTML to close the output file, and then reopen ODS HTML. */
ods html close;
ods html; /* Not required in SAS Studio */
