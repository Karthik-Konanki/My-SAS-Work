 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GONCSWB1                                           |
   |   TITLE: GONCSWB1-Creating a Simple Web Page with ODS       |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS MAPS PATTERN GMAP                         |
   |   PROCS: GMAP                                               |
   |    DATA: INTERNAL sashelp.demographics                      |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF     UPDATE: JAN 2011                |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   |    MISC:  USE HTML for THE RESULTS                          |
   |  UPDATE: NOV 2019:decrease # of legend keys & adjust        |
   |                   legend position                           |
   |     REF: SAS/GRAPH & Base SAS MAPPING REFERENCE             |
   |  UPDATE: APR 2020: modified for SAS Studio                  |
   |                                                             |
   +-------------------------------------------------------------+*/

 /* Output displays in SAS Studio 3.8 or later Results tab */
 
    /* Define title */
 title1 "North America Gross National Income per Capita 2004";

    /* Define legend characteristics   */
 legend across=1
        position=(bottom left)
        offset=(1.25pct,40pct)
        mode=share
        label=(position=top
              "Gross National Income per Capita")
        shape=bar(.15in,.10in)
        order=descending
 ;

   /* Create a choropleth map of income */
 proc gmap map=mapssas.namerica data=sashelp.demographics;
        id cont id;
        format gni dollar10.0;
      choro gni / levels=5 legend=legend1
                  des='' name="gonscwb1";
 run;
 quit;

