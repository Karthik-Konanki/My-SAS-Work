 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GSLTEXTS                                           |
   |   TITLE: GSLTEXTS-Producing Text Slides                     |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS GOPTIONS GSLIDE                           |
   |   PROCS: GSLIDE                                             |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 21APR2020      |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:                                                    |
   |                                                             |
   +-------------------------------------------------------------+*/

/* Set graphics environment */
goptions reset=all cback=blue border;

/* Define titles and footnotes */
title color=yellow "New Directions";
footnote1 j=l color=yellow" ABC Engineering, Inc";
footnote2 j=l color=yellow" January 2020";

/* Generate slide */
proc gslide border
    cframe=darkred
    wframe=2;
    note height=14;
    note height=5
       justify=center 
       color=white 
       "Goals and strategies"
       justify=center 
       "for the coming year";
run;
quit;
