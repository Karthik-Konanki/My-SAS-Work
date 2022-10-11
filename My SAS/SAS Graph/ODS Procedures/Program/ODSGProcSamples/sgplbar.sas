 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGPLBAR                                            |
   |   TITLE: SGPLBAR-Creating a Bar-Line Chart                  |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGPLOT VBAR VLINE                                  |
   |   PROCS: SGPLOT                                             |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/


proc sgplot data=sashelp.stocks (where=(date >= "01jan2000"d
                                 and date <= "01jan2001"d
                                 and stock = "IBM"));
   title "Stock Volume vs. Close";

   /*Create the bar chart.
   RESPONSE= specifies the response variable.*/

   vbar date / response=volume;

   /*Create the line chart.
   RESPONSE= specifies the response variable.
   Y2AXIS assigns the chart to the Y2 axis. */


   vline date / response=close y2axis;


run;

title;
