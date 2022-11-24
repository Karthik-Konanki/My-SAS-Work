 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GBLWTSTA                                    |
   |   TITLE: GBLWTSTA-Calculating Weighted Statistics    |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GBARLINE                           |
   |   PROCS: GCHART                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: APR 11        |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

/* Set the graphics environment */
goptions reset=all border;

/* This graph uses the data set entitled FAILURE found in
   the SASHELP library. Each observation of the FAILURE data
   set contains the type of manufacturing defect and a count
   of how many times it occurred. Define data that associates
   a cost with each defect. Assign a label of 'Defect' in
   place of the variable name in the data set.*/

data myfail;
   set sashelp.failure;
   label Cause='Defect';
    select (Cause) ;
      when ("Contamination")  Cost=3.5;
      when ("Metallization")  Cost=10;
      when ("Oxide")          Cost=10.5;
      when ("Corrosion")      Cost=4.5;
      when ("Doping")         Cost=3.6;
      when ("Silicon")        Cost=5.4;
      otherwise               Cost=1.0;
    end;
run;

/* Define the title */
title1 "The Cost of Defects";

/* Define the labels for the axes */
axis1 label=("Defect Count");
axis2 label=("Total Cost");

/* Produce the bar-line chart */
proc gbarline data=myfail;
   bar Cause / sumvar=Count axis=axis1;
   plot / sumvar=Count freq=cost axis=axis2;
run;
quit;
