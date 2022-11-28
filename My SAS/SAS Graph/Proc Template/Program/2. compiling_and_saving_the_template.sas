/*Compiling and Saving the Template*/


/*Current template search path*/
ods path show;

/*Viewing list of templates in sas*/

proc template;
	list styles;
run;

proc template;
	list stat;
run;

/*List the templates that are stored in the sasuser.template*/
proc template;
	list/store = sasuser.templat;
run;

/*List the templates that are stored in the sashelp.tmplmst*/

proc template;
	list/store = sashelp.tmplmst;
run;

/*List the templates that are stored in the sashelp.tmplstat*/

proc template;
	list/store = sashelp.tmplstat;
run;

/*List the templates that are stored in the sashelp.tmplets*/

proc template;
	list/store = sashelp.tmplets;
run;

/*List the templates that are stored in the sashelp.tmplqc*/

proc template;
	list/store = sashelp.tmplqc;
run;

/*List the templates that are stored in the sashelp.tmpliml*/

proc template;
	list/store = sashelp.tmpliml;
run;


/*Code for a template that is stored in the Sasuser writes in log window*/

proc template;
	path sasuser.templat;
	source <template-name>;
run;


/*Example*/
proc template;
	path sasuser.templat;
	source swimmer;
run;


ods path show;

proc template;
	list/store=sasuser.templat;
run;

proc template;
	path sasuser.templat;
	source disdur;
run;


proc template;
	list/store=sashelp.tmplmst;
run;

proc template;
	path sashelp.tmplmst;
	source Base.Contents;
run;

proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.CrossSeriesPlot;
run;

/*Code for a template that is stored and writes into custom file*/
/*View the source code for an ODS template*/

proc template;
     source styles.default / file='c:\sas\template.sas.';
run;

/**Use command "odstemplates" to get templates in SAS9.4 windowing environment**/
