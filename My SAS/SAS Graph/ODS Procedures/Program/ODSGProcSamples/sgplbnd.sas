 /*+-------------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                      |
   |                                                                   |
   |    NAME: SGPLBND                                                  |
   |   TITLE: SGPLBND-Creating Lines and Bands From Pre-Computed Data  |
   | PRODUCT: BASE                                                     |
   |  SYSTEM: ALL                                                      |
   |    KEYS: SGPLOT SCATTER SERIES BAND KEYLEGEND                     |
   |   PROCS: SGPLOT                                                   |
   |    DATA: EXTERNAL                                                 |
   |                                                                   |
   | SUPPORT: BASE STAFF                         UPDATE: NOV 2010      |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                        |
   +-------------------------------------------------------------------+*/


proc sgplot data=sashelp.classfit;
  title "Fit and Confidence Band from Precomputed Data";

 /* Create the first band.
  *  LOWER= specifies the lower edge.
  *  UPPER=specifies the upper edge.
  *  LEGENDLABEL= specifies the label for the band in the legend.
  *  NAME= specifies the name of the band plot.*/

  band x=height lower=lower upper=upper /
       legendlabel="95% CLI" name="band1";

 /* Create the first band.
  * LOWER= specifies the lower edge.
  * UPPER=specifies the upper edge.
  * FILLATTRS= specifies the style element for the fill.
  * LEGENDLABEL= specifies the label for the band in the legend.
  * NAME= specifies the name of the band plot.*/

  band x=height lower=lowermean upper=uppermean /
       fillattrs=GraphConfidence2
       legendlabel="95% CLM" name="band2";

 /* Create the scatter plot.*/

  scatter x=height y=weight;

 /* Create the series plot.
  * LINEATTRS= specifies the style element for the series curve.
  * LEGENDLABEL= specifies the label for the series plot in the legend.
  * NAME= specifies the name of the series plot.*/

  series x=height y=predict / lineattrs=GraphPrediction
         legendlabel="Predicted Fit" name="series";

 /* Position the Legend.
  * The quoted strings specify the plots that you want to include.
  * The LOCATION= option places the legend inside of the data area.
  * The POSITION= option places the legend at the bottom right.*/

  keylegend "series" "band1" "band2" / location=inside position=bottomright;
run;
title;
