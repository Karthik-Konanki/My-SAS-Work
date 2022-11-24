/*+--------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                |
   |                                                             |
   |    NAME: GTLCOLOR                                           |
   |   TITLE: GTLCOLOR - Specifying the Colorramp= Option,       |
   |          and Setting the Detaillevel= Option                |
   | PRODUCT: GRAPH                                              |
   |  SYSTEM: ALL                                                |
   |    KEYS: GRAPHICS ODS GTILE                                 |
   |   PROCS: GTILE                                              |
   |    DATA: SASHELP.ORSALES (Subset)                           |
   |                                                             |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 20APR2020            |
   |     REF: SAS/GRAPH REFERENCE GUIDE                          |
   +-------------------------------------------------------------+*/
/* Create a fileref for the output.                               */
filename odsout "file-path";

/*   Subset the data.                                             */
data sports_only;
   set sashelp.orsales;
      if product_line="Sports";
   format profit dollar12.;
   format quantity comma12.;
run;

/*   Close the currently open ODS destinations.                   */
ods _all_ close;

/*   Set graphic options.                                         */
goptions reset=all device=javaimg noborder;

/*   Open the HTML output destination and specify the output      */
/*   path and filename.                                           */
ods html path=odsout file='sport_sales.html';

/*   The chart variable QUANTITY specifies the size of the tiles. */
/*   The FLOW layout arranges the tiles.                          */
/*   The TILEBY keyword variable-list defines the tile-segments   */
/*   and levels.                                                  */
/*   The COLORVAR= option specifies the variable to use to color  */
/*   the tiles.                                                   */
/*   The DETAILLEVEL=1 option defines the level of display detail.*/
/*   The COLORRAMP= option reverses the colors. Blue represents   */
/*   the highest value.                                           */
/*   Red represents the lowest value.                             */

proc gtile data=sports_only;
   flow quantity tileby=(product_group year) /
      colorvar=profit
      detaillevel=1
      colorramp=(CXDD6060 CXFFFFFF CX6497EB);
run;
quit;

/*   Close the HTML output destination to close the output file.  */
ods html close;