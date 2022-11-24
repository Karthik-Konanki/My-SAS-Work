 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHERRBR                                    |
   |   TITLE: GCHERRBR-Error Bars in a Horiz Bar Chart    |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART AXIS PATTERN LEGEND         |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: FEB 2011      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/

goptions reset=all border;



/* Create the data set FITNESS. FITNESS contains age and sex of
participants, as well as the
number of times they exercise each week and their resting
heart rate and aerobic power. */

data fitness;
input age sex $ heart exer aero;
datalines;
28 M 86 2 36.6
41 M 76 3 26.7
30 M 78 2 33.8
29 M 54 3 44.8
48 F 66 2 28.9
36 F 66 2 33.2
;



/* Define the title. */

title1 "Average Resting Heart Rate by Age";
/* footnote j=r "GCHERRBR"; */



/* Modify the axis labels. AXIS1 is assigned to the response ax
is and AXIS2 is assigned to the
midpoint axis. */

axis1 label=("Heart Rate" j=c "Error Bar Confidence Limits: 95%")
minor=(number=1);
axis2 label=("Age" j=r "Group");



/* Produce the horizontal bar chart. SUMVAR= calculates the mean of the
variable HEART for all the observations in each midpoint group.
TYPE= specifies the mean statistic for the summary variable,
HEART. FREQLABEL= and MEANLABEL= specify new column labels for
the frequency and mean statistics. ERRORBAR= draws the error bars
as empty bars and CERROR allows the vertical line on the third error
bar to be visible. CLM= specifies the confidence level.
NOFRAME suppresses the axis area frame. */

proc gchart data=fitness;
hbar age / type=mean
sumvar=heart
freqlabel="Number in Group"
meanlabel="Mean Heart Rate"
errorbar=bars
cerror=orange
clm=95
midpoints=(30 40 50)
raxis=axis1
maxis=axis2
noframe;
run;
quit;
