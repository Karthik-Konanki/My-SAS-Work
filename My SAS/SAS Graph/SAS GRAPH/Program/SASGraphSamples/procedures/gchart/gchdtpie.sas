/*+--------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GCHDTPIE                                           |
   |   TITLE: GCHDTPIE-Detail Pie Chart                          |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GCHART                                    |
   |   PROCS: GCHART                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: FEB 2011       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/

/* Set the  graphics environment */
goptions reset=all border;

/* Define the title. */

title 'Types of Vehicles Produced Worldwide (Details)';
/* footnote1 j=r 'GCHDTPIE'; */

/* Produce the detail pie chart.
   This graph uses the data set entitled CARS found in the
   SASHELP library.   DETAIL= produces a inner pie overlay
   showing the percentage that each DRIVETRAIN contributes toward
   each type of vehicle. DETAIL_PERCENT= and DETAIL_SLICE= control
   the positioning of the detail slice labels. DETAIL_VALUE= turns
   off the display of the number of DRIVETRAINS for each detail
   slice.  DETAIL_THRESHOLD= shows all detail slices that
   contribute more than two percent of the entire pie. */

proc gchart data=sashelp.cars;
pie type / detail=drivetrain
detail_percent=best
detail_value=none
detail_slice=best
detail_threshold=2
legend
;
run;
quit;
