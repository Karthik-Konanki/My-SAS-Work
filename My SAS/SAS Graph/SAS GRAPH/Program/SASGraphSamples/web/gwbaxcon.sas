 /*+------------------------------------------------------------+
  |          S A S   S A M P L E   L I B R A R Y                |
  |                                                             |
  |    NAME: GWBAXCON                                           |
  |   TITLE: GWBAXCON-Generating an Interactive Contour Plot    |
  | PRODUCT: GRAPH                                              |
  |  SYSTEM: ALL, browse HTML output in Windows                 |
  |    KEYS: GRAPHICS ACTIVEX GCONTOUR ODS                      |
  |   PROCS: GCONTOUR                                           |
  |    DATA: INTERNAL                                           |
  |                                                             |
  | SUPPORT: GRAPHICS STAFF              UPDATE: 20APR2020      |
  |     REF: SAS/GRAPH REFERENCE GUIDE                          |
  |    MISC: The HTML output file runs an ACTIVEX control from  |
  |          SAS, which must be installed on the host prior to  |
  |          displaying the HTML file in a Web browser.         |
  +-------------------------------------------------------------+*/

/* Create a fileref for the ODS output */
filename odsout "output-path";

/* Close the currently open ODS destinations.  */
ods _all_ close;

/* Open ODS HTML and specify the output path and filename.  */
ods html path=odsout file="your_HTML_file.htm";

/* Specify the ACTIVEX driver and set up customizations. */
goptions   device=activex
           xpixels=500      ypixels=350
           border           cback=white
           gunit=pct        htext=3;

/* Enter the data for the graph. */
data atoll;
     input vdist hdist depth;
datalines;
10    0.25     2.77
20    0.25     2.77
30    0.25     2.77
40    0.25     2.77
50    0.25     2.77
60    0.25     2.77
70    0.25     2.77
80    0.25     2.77
90    0.25     2.77
100   0.25     2.77
10    44       3.08
18    27.5     3.38
24    11.25    3.59
30    7.5      3.51
44    1.25     3.53
60    10       3.49
10    41.25    3.38
10    36.25    3.41
10    31.25    3.50
10    26.25    3.53
10    21.25    3.23
10    16.25    2.95
10    11.25    2.87
10    6.25     2.87
10    1.25     2.77
68    10       3.10
76    10       3.27
84    11.25    3.37
20    1.25     2.77
30    1.25     2.77
40    1.25     2.77
50    1.25     2.77
60    1.25     2.77
70    1.25     2.77
80    1.25     2.77
90    1.25     2.77
34    6.25     2.77
34    7.5      2.77
34    10       2.77
54    5        3.10
54    6.25     3.10
54    8.75     3.10
82    5        3.42
82    6.25     3.42
82    8.75     3.42
94    10       3.74
96    8.75     3.74
98    7.5      3.74
90    13.75    3.41
96    17.5     3.64
100   21.875   3.69
104   6.25     3.80
106   41.25    3.72
108   51.25    3.69
110   71.25    3.54
110   111.25   3.80
108   121.25   3.95
108   131.25   3.87
106   141.25   3.70
104   153.75   3.51
88    151.25   3.46
72    151.25   3.04
56    148.75   2.80
40    145      2.67
24    138.75   2.62
0     127.5    2.15
88    152.5    3.46
88    153.75   3.46
72    152.5    3.04
72    153.75   3.04
56    150      2.80
56    152.5    2.80
40    146.25   2.67
40    148.75   2.67
24    141.25   2.62
0     130      2.15
6     137.5    3.72
26    150      3.90
0     132.5    2.15
10    48.75    3.06
8     58.75    2.98
6     63.75    3.00
6     68.75    3.23
4     78.75    3.31
2     88.75    3.36
2     98.75    3.31
0     108.75   3.31
0     118.75   3.36
0     138.75   2.95
0     148.75   2.85
0     153.75   2.46
86    18.75    4.62
88    18.75    4.62
90    19       4.62
92    19       4.62
94    20       4.62
96    21.25    4.62
98    23.75    4.62
100   27.5     4.62
101   30       4.62
102   32.5     4.62
103   35       4.62
103.5 36.25    4.62
104   37.5     4.62
104   38.75    4.62
104   40       4.62
104   43.75    4.62
104   47.5     4.62
105   52.5     4.62
106   58.75    4.62
106   62.5     4.62
107   66.25    4.62
107   70       4.62
107   73.75    4.62
106   77.5     4.62
106   81.25    4.62
107   85       4.62
107   88.75    4.62
109   93.75    4.62
110   96.25    4.62
110   98.75    4.62
110   102.5    4.62
110   105      4.62
109   107.5    4.62
108   111.25   4.62
106   113.75   4.62
106   116.25   4.62
105   118.75   4.62
104   123.75   4.62
104   130      4.62
104   135      4.62
103   138.75   4.62
102   142.5    4.62
101   145      4.62
98    146.875  4.62
94    147.5    4.62
88    148.125  4.62
82    147.5    4.62
76    147.5    4.62
68    146.875  4.62
60    145.625  4.62
52    143.75   4.62
48    142.5    4.62
46    141.875  4.62
44    141.25   4.62
43    140      4.62
40    137.5    4.62
38    135      4.62
37    132.5    4.62
35    128.75   4.62
34    125      4.62
33    121.25   4.62
33    116.25   4.62
33    112.5    4.62
34    108.75   4.62
34    106.25   4.62
34    103.75   4.62
34    101.25   4.62
33    98.75    4.62
31    95       4.62
29    91.25    4.62
26    87.5     4.62
25    85       4.62
23    82.5     4.62
22    78.75    4.62
21    73.75    4.62
21    70       4.62
21    67.5     4.62
21    63.75    4.62
22    60       4.62
23    56.25    4.62
26    51.25    4.62
28    47.5     4.62
29    46.25    4.62
31    45       4.62
36    40       4.62
40    36.875   4.62
44    32.5     4.62
46    30       4.62
50    28.125   4.62
56    25       4.62
64    23.125   4.62
72    21.25    4.62
78    20       4.62
82    19.375   4.62
84    15.625   4.31
80    16.25    4.31
74    17.5     4.31
68    18.75    4.31
58    21.25    4.31
50    23.75    4.31
44    26.25    4.31
40    30       4.31
36    33.125   4.31
32    37.5     4.31
29    40       4.31
26    42.5     4.31
24    45       4.31
20    45       4.31
16    45       4.31
1     125      2.15
6     131.25   2.23
6     135      2.23
14    138.75   2.26
16    136.25   2.26
2     137.5    2.15
20    158.75   2.00
30    166.25   1.85
40    171.25   1.69
50    173.75   1.54
60    176.25   1.54
70    177.5    1.54
80    177.5    1.54
90    177.5    2.15
100   176.25   2.46
106   171.25   2.77
108   165      3.08
106   158.75   3.38
28    146.25   3.90
18    150      3.90
26    157.5    3.94
32    155      3.94
36    150      3.94
34    163.75   3.97
42    160      3.97
48    153.75   3.97
50    168.75   4.00
54    163.75   4.00
60    156.25   4.00
64    171.25   4.00
72    166.25   4.00
72    156.25   4.00
80    172.5    4.00
86    166.25   4.00
88    156.25   4.00
98    172.5    4.00
104   165      4.00
100   156.25   4.00
84    20       4.64
88    20       4.64
92    20       4.64
94    21.25    4.64
90    21.25    4.64
86    21.25    4.77
82    21.25    4.77
78    21.25    4.69
70    22.5     5.13
80    22.5     5.08
86    22.5     4.92
92    22.5     4.77
96    22.5     4.69
96    23.75    4.77
92    23.75    4.92
86    23.75    5.38
83    23.75    5.38
80    23.75    5.08
76    23.75    4.92
70    23.75    4.92
66    23.75    4.77
58    26.25    5.08
62    26.25    5.08
66    26.25    5.54
72    26.25    5.69
76    26.25    5.54
80    26.25    5.38
84    26.25    5.23
88    26.25    5.23
94    26.25    5.08
98    26.25    4.92
48    31.25    4.92
52    31.25    5.23
58    31.25    5.54
64    31.25    5.69
68    31.25    5.85
72    31.25    5.85
76    31.25    5.69
80    31.25    5.69
84    31.25    5.54
90    31.25    5.38
94    31.25    5.23
100   31.25    4.92
38    41.25    4.92
44    41.25    4.92
50    41.25    4.92
54    41.25    5.23
60    41.25    5.38
64    41.25    5.69
68    41.25    5.85
74    41.25    5.85
80    41.25    6.00
84    41.25    6.15
88    41.25    5.69
96    41.25    5.23
102   41.25    4.92
28    51.25    4.77
34    51.25    4.92
40    51.25    4.92
44    51.25    4.92
48    51.25    5.23
54    51.25    5.23
60    51.25    5.23
64    51.25    5.54
68    51.25    5.54
74    51.25    5.85
80    51.25    5.85
86    51.25    5.85
92    51.25    5.85
94    51.25    5.69
98    51.25    5.23
102   51.25    5.08
24    61.25    4.77
30    61.25    4.92
36    61.25    4.92
42    61.25    5.23
48    61.25    5.54
54    61.25    5.54
60    61.25    5.85
66    61.25    5.85
69    61.25    5.85
72    61.25    6.00
78    61.25    6.00
81    61.25    5.85
84    61.25    5.85
90    61.25    5.38
93    61.25    5.23
96    61.25    5.08
100   61.25    4.92
104   61.25    4.77
24    71.25    4.77
32    71.25    5.08
40    71.25    5.54
48    71.25    5.69
54    71.25    5.69
60    71.25    5.85
68    71.25    5.85
74    71.25    6.00
80    71.25    6.00
88    71.25    6.15
96    71.25    6.15
100   71.25    5.54
102   71.25    4.92
24    81.25    4.77
28    81.25    4.92
32    81.25    4.92
36    81.25    5.54
40    81.25    5.85
44    81.25    5.85
50    81.25    6.00
56    81.25    6.00
62    81.25    6.15
68    81.25    6.15
74    81.25    6.15
80    81.25    6.15
86    81.25    6.00
92    81.25    5.85
98    81.25    5.38
100   81.25    5.38
104   81.25    4.92
32    91.25    4.77
68    91.25    6.00
90    91.25    6.15
94    91.25    5.69
98    91.25    5.23
102   91.25    5.08
106   91.25    4.77
36    91.25    4.77
40    91.25    4.92
44    91.25    4.92
48    91.25    5.23
52    91.25    5.69
56    91.25    5.69
60    91.25    5.85
64    91.25    6.00
68    91.25    6.00
72    91.25    6.15
74    91.25    6.15
78    91.25    6.46
82    91.25    6.46
86    91.25    6.31
36    101.25   4.77
38    101.25   4.92
40    101.25   5.23
42    101.25   5.23
44    101.25   5.85
48    101.25   6.00
52    101.25   6.00
56    101.25   6.15
60    101.25   6.31
64    101.25   6.31
68    101.25   6.46
72    101.25   6.46
76    101.25   6.77
80    101.25   6.77
84    101.25   6.62
88    101.25   6.46
92    101.25   5.69
96    101.25   5.23
100   101.25   5.23
104   101.25   5.08
108   101.25   4.77
36    111.25   4.77
40    111.25   4.92
44    111.25   5.38
48    111.25   5.38
52    111.25   5.54
56    111.25   5.54
60    111.25   5.54
64    111.25   5.69
68    111.25   5.69
72    111.25   6.00
76    111.25   6.15
80    111.25   6.46
84    111.25   6.31
88    111.25   6.15
92    111.25   6.00
96    111.25   5.85
100   111.25   5.54
102   111.25   5.54
104   111.25   5.23
106   111.25   4.77
36    121.25   4.77
40    121.25   4.77
44    121.25   5.08
48    121.25   5.08
52    121.25   5.23
56    121.25   5.23
60    121.25   5.23
64    121.25   5.38
68    121.25   5.54
72    121.25   6.15
76    121.25   6.15
80    121.25   6.15
84    121.25   5.69
88    121.25   5.54
92    121.25   5.38
96    121.25   4.92
100   121.25   4.92
102   121.25   4.77
48    141.25   4.77
52    141.25   4.92
60    141.25   5.08
64    141.25   5.69
68    141.25   5.38
72    141.25   5.54
80    141.25   5.69
84    141.25   5.69
88    141.25   5.54
92    141.25   5.69
96    141.25   5.38
100   141.25   5.08
58    143.75   5.08
64    143.75   5.23
72    143.75   5.23
80    143.75   5.23
88    143.75   5.38
94    143.75   5.23
100   143.75   5.08
76    145      5.23
86    145      5.38
92    145      5.23
98    145      5.08
68    145      5.08
80    146.875  5.08
92    146.875  5.08
96    146.875  5.08
62    136.875  4.62
60    137.5    4.62
60    136.25   4.62
60    135      4.62
62    136.25   4.62
62    135      4.62
40    141.25   4.77
44    141.25   5.08
48    141.25   5.08
52    141.25   5.38
56    141.25   5.54
60    141.25   5.54
64    141.25   5.54
68    141.25   5.85
72    141.25   5.85
76    141.25   5.69
84    141.25   5.85
92    141.25   5.38
96    141.25   5.23
100   141.25   4.92
44    137.5    5.08
48    137.5    5.08
52    137.5    5.23
56    137.5    5.08
58    137.5    5.00
64    137.5    5.00
66    137.5    5.00
70    137.5    5.23
74    137.5    5.54
78    137.5    5.69
82    137.5    5.69
86    137.5    5.69
90    137.5    5.23
94    137.5    5.23
98    137.5    5.08
102   137.5    5.08
58    136.25   5.08
58    135      5.08
60    133.75   5.00
62    133.75   5.00
64    135      5.00
64    136.25   5.00
60    138.75   5.08
62    138.75   5.08
;
run;

/* Prepare the data to be a rectangular grid   */
/* of points.                                  */
proc g3grid data=atoll out=atollgrid;
     grid vdist*hdist=depth / naxis1=50 naxis2=50;
run;

title 'Pacific Atoll';

/* Customize the legend and axes of the plot.  */
axis1 order=(0 to 150 by 25)   c=cx002288 width=3
      minor=(n=4)              label=('Meters');
axis2 order=(0to 100 by 25)    c=cx002288 width=3
      minor=(n=4)              label=('Meters');

legend1 frame
      label=(position=top j=c 'Depth (in meters)')
      shape=line(7);

/* Produce the contour plot. */
proc gcontour data=atollgrid;
     plot vdist*hdist=depth /
     levels = 1  2  2.5  3  3.5  4  4.5  5  7  9
     clevels = CXFF0000 CXF07275 CXEC9592
               CXE9A2B2 CXE5BFC6 CXBFA0CF
               CX9981D8 CX7362E1 CX4D43EA
               CX0000FF
     legend=legend1
     haxis=axis1
     vaxis=axis2
     des='Atoll';
run;
quit;

/* Close the ODS HTML destination */
ods html close;
