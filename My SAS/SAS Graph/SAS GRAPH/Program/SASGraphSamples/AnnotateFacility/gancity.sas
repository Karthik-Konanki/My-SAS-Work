 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GANCITY                                            |
   |   TITLE: GANCITY-Labeling Cities on a Map                   |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS ANNOTATE PATTERN GMAP                     |
   |   PROCS: GMAP                                               |
   |    DATA: INTERNAL                                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 01JUL2008      |
   | SUPPORT: GRAPHICS STAFF              UPDATE: 24OCT2016      |
   | UPDATE: 18APR2019 used GfK data set in 2nd DATA step |
   | Now runs in V9cas and 9.4x              |
   |     REF: SAS/GRAPH MAPPING REFERENCE GUIDE   |  
   | SUPPORT: added stat=first            UPDATE: 18MAY2020      |
   +-------------------------------------------------------------+*/

   /* set the graphics environment */
goptions reset=all border;

   /* subset US data set */
data lower48;
   set mapsgfk.us;
   if state ne stfips('AK');
   if state ne stfips('HI');
   if state ne stfips('PR');
run;

   /* create the Annotate data set, CITYSTAR */
data citystar;
   length function style color $ 8 position $ 1
          text $ 20;
   retain xsys ysys '2' hsys '3'
          when 'a';
   set mapsgfk.uscity(keep=x y city state);
        if (city='Atlanta' and state=13)
       or (city='Chicago' and state=17)
       or (city='Seattle' and state=53);
     function='symbol'; style='marker'; text='V'; color='red'; size=5;
     output;
     function='label'; style=''; text=city; color='green';
     size=5; position='8'; output;
run;

   /* define the title and footnote */
title 'Distribution Center Locations';

   /* define pattern characteristics */
pattern value=mempty color=blue repeat=49;

   /* define the footnote */
footnote j=r "This map drawn with GFK map data";

   /* generate annotated map */
proc gmap data=lower48 map=lower48;
   id state;
   choro state / annotate=citystar discrete
                 stat=first nolegend;
run;
quit;
