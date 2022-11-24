/*+------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: GTLSIMPL                                               |
   |   TITLE: GTLSIMPL- Simple GTILE with the COLORVAR= Option       |
   | PRODUCT: GRAPH                                                  |
   |  SYSTEM: ALL                                                    |
   |    KEYS: GRAPHICS ODS GTILE                                     |
   |   PROCS: GTILE                                                  |
   |    DATA: SASHELP.SHOES                                          |
   |                                                                 |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 20APR2020                |
   |     REF: SAS/GRAPH REFERENCE GUIDE                              |
   +-----------------------------------------------------------------+*/
/* Create a fileref for the output.                                   */
filename odsout "file-path";

/*   Close the currently open ODS destinations.                       */
ods _all_ close;

/*   Set graphic options.                                             */
goptions reset=all device=javaimg noborder;

/*   Open the HTML output destination and specify the output          */
/*   path and filename.                                               */
ods html path=odsout file="shoe_sales.html";

/*   The chart variable STORES specifies the size of the tiles.       */
/*   The TILE layout arranges the tiles.                              */
/*   The TILEBY keyword variable-list defines the tile-segments
/*   and levels.                                                      */
/*   The COLORVAR= option specifies the variable to use to color
/*   the tiles.                                                       */

proc gtile data=sashelp.shoes;
   tile stores tileby=(region subsidiary)/
      colorvar=sales ;
run;
quit;

/*    Close the HTML output destination to close the output file.     */
ods html close;