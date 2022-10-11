 /*+-------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: SGREND1                                            |
   |   TITLE: SGREND1-Defining Dynamic Variables                 |
   | PRODUCT: BASE                                               |
   |  SYSTEM: ALL                                                |
   |    KEYS: SGRENDER GTL                                       |
   |   PROCS: SGRENDER                                           |
   |    DATA: EXTERNAL                                           |
   |                                                             |
   | SUPPORT: BASE STAFF              UPDATE: NOV 2010           |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                  |
   +-------------------------------------------------------------+*/

/*Define the template.*/

proc template ;
 define statgraph distribution;
  dynamic VAR VARLABEL TITLE NORMAL _BYLINE_;
  begingraph;
    entrytitle TITLE;
    entrytitle _BYLINE_;
    layout lattice / columns=1 rows=2  rowgutter=2px
                     rowweights=(.9 .1) columndatarange=union;
      columnaxes;
        columnaxis / label=VARLABEL;
      endcolumnaxes;
      layout overlay / yaxisopts=(offsetmin=.035);
      layout gridded / columns=2 border=true autoalign=(topleft topright);
           entry halign=left "Nobs";
           entry halign=left eval(strip(put(n(VAR),8.)));
           entry halign=left "Mean";
           entry halign=left eval(strip(put(mean(VAR),8.2)));
           entry halign=left "StdDev";
           entry halign=left eval(strip(put(stddev(VAR),8.3)));
               endlayout;
        histogram VAR / scale=percent;
        if (exists(NORMAL))
          densityplot VAR / normal( ) ;
        endif;
        fringeplot VAR / datatransparency=.7;
      endlayout;
      boxplot y=VAR / orient=horizontal;
    endlayout;
  endgraph;
 end;
run;


/*Generate the first graph output using the SASHELP.HEART data set.
The DYNAMIC statement defines dynamic variables in the template. */

proc sgrender data=sashelp.heart template=distribution;
  dynamic var="cholesterol" varlabel="Cholesterol (LDL)" normal="yes"
          title="Framingham Heart Study";
run;

/*Sort the SASHELP.CARS data set.*/

proc sort data=sashelp.cars out=cars;
  by origin;
run;

/*Generate the second graph output using the WORK.CARS dataset.
The BY statement specifies a BY variable to create multiple graphs.
The DYNAMIC statement defines dynamic variables in the template. */

proc sgrender data=cars template=distribution;
  by origin;
  dynamic var="weight" varlabel="Weight in LBS"
          title="Distribution of Vehicle Weight";
run;

title;
