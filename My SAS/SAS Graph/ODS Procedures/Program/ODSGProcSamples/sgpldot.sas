 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLDOT                                            |
   |   TITLE: SGPLDOT-Adding Statistical Limits to a Dot Plot    |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT DOT                                         |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

proc sgplot data=sashelp.class(where=(age<16));

  /*Create the dot plot.
  RESPONSE= specifies the response variable.
  STAT= specifies the statistic for the horizontal axis.
  LIMITSTAT= specifies the statistic for the limits.
  NUMSTD= specifies the number of standard deviations for the limits.*/

  dot age / response=height stat=mean
            limitstat=stddev numstd=1;
run;
