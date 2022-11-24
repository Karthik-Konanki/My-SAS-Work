 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GCHBRMID                                    |
   |   TITLE: GCHBRMID-Midpoints/Stats in Horiz Bar Chart |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GCHART AXIS LEGEND                 |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 17DEC2010     |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment.  Generate a border around graph.*/

goptions reset=all border;



/* Create the data set FITNESS. FITNESS contains age and sex of
participants, as well as the number of times they exercise each
week and their resting heart rate and aerobic power. */

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

title1 "Fitness Program Participants";


/* Modify the response axis. OFFSET= moves the first and last tick
marks to the ends of the axis line. ORDER= places major tick
marks on the response axis from 1 to 14. */

axis1 label=("Number of People")
minor=(number=1)
offset=(0,0);


/* Modify the legend. VALUE= specifies the text that describes
the values. */

legend1 label=none
value=("Women" "Men");


/* Produce the first horizontal bar chart. Because neither
MIDPOINTS= nor DISCRETE is used, the procedure automatically selects
the midpoints. SUBGROUP= divides the bars according to the values of
SEX and automatically generates a legend. AUTOREF adds reference
lines to the chart at each major tick mark. CLIPREF positions the
reference lines behind the bars. WREF= sets the reference line
width to 1 pixel. CREF sets the reference line color to green.
LREF= sets the reference line type to 4 (dashed line).*/

proc gchart data=fitness;
hbar age / subgroup=sex
legend=legend1
autoref
clipref
raxis=axis1
wref=1
cref=green
lref=4
;
run;


/* Modify the response axis for the second chart. ORDER= places major
tick marks on the response axis at intervals of 1. */

axis1 order=(0 to 4 by 1)
label=('Number of People')
minor=(number=1)
offset=(0,0);


/* Modify the midpoint axis label for the second chart. */

axis2 label=("Age " j=r "Group");


/* Produce the second horizontal bar chart with modified midpoints.
MIDPOINTS= specifies the middle value of the range of values represented
by each bar. FREQ requests that only the frequency statistic appears in the
table. FREQLABEL= specifies the text for the column header in the table
of statistics. */

hbar3d age / midpoints=(30 40 50)
freq
freqlabel="Total in Group"
subgroup=sex
autoref
maxis=axis2
raxis=axis1
legend=legend1
coutline=black
clipref
wref=1
cref=green
lref=4
;
run;
quit;
