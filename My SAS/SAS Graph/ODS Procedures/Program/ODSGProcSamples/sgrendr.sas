 /*+-----------------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y                    |
   |                                                                 |
   |    NAME: SGRENDR                                                |
   |   TITLE: SGRENDR-Generating a Graph from a Simple GTL Template  |
   | PRODUCT: BASE                                                   |
   |  SYSTEM: ALL                                                    |
   |    KEYS: SGRENDER GTL                                           |
   |   PROCS: SGRENDER                                               |
   |    DATA: EXTERNAL                                               |
   |                                                                 |
   | SUPPORT: BASE STAFF                       UPDATE: NOV 2010      |
   |     REF: SAS ODS GRAPHICS PROCEDURES GUIDE                      |
   +-----------------------------------------------------------------+*/

/*Define the template*/

proc template;
  define statgraph surface;
    begingraph;
      layout overlay3d;
        surfaceplotparm x=height y=weight z=density;
      endlayout;
    endgraph;
  end;
run;

/*Generate the graph output.
DATA= specifies the data set.
TEMPLATE= specifies the statgraph template.*/

proc sgrender data=sashelp.gridded template=surface;
run;
