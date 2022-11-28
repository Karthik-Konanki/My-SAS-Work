ods path show;

ods graphics / reset width=460px height=440px; 
ods rtf style=Daisy path="E:\NewDisk\SAS\My SAS\SAS Graph\Proc Template\Output" file="mychart - stachkedbar.rtf"; 

proc sort data=sashelp.cars out=cars; 
	by type;
run;

proc template; 
	define statgraph mygraphtemplate;
		begingraph;
			entryfootnote "Data: SASHELP.CARS";
			layout overlay / xaxisopts=(label="Vehicle Type") yaxisopts=(label="Models Produced"
							 griddisplay=on gridattrs=(color=gray pattern=dot));
				barchart category=type / name="bar" stat=freq barlabel=true
						 group=origin;
				discretelegend "bar" / title="Origin"; 
			endlayout; 
		endgraph;
	end;
run;

proc sgrender data=cars template=mygraphtemplate; 
run;

ods rtf close; 



proc template;
	list/store=sasuser.templat;
run;

*===============================================;
/* Deleteing template that specified*/

proc template;
	delete mygraphtemplate/store=sasuser.templat;
run;

/*or */

/*Delete template from default library*/

proc template;
	delete mygraphtemplate;
run;


proc template;
	list/store=sasuser.templat;
run;

*================================================;

/*LINK - Creates a link to an existing item.*/

proc template;
	link mygraphtemplate1 to mygraphtemplate;
run;

proc template;
	list/store=sasuser.templat;
run;

*================================================;

/*LIST - Lists the items in one or more template stores.*/

/*list all templates*/
proc template;
	list/store=sashelp.tmplmst;
run;

/*list specific templates in ascending order*/

proc template;
	path sashelp.tmplmst;
	list base.univariate/sort=type ascending;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/sort=size a;
run;


proc template;
	path sashelp.tmplmst;
	list base.univariate/sort=notes descending;
run;


proc template;
	path sashelp.tmplmst;
	list base.univariate/sort=path d;
run;


proc template;
	path sashelp.tmplmst;
	list base.univariate/sort=created a;
run;

/*specifies the information to include in the list of items.*/

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=all;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=store;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=created;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=notes;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=link;
run;

proc template;
	path sashelp.tmplmst;
	list base.univariate/stats=size;
run;

/*specifies the template store to process.*/

proc template;
	path sashelp.tmplmst;
	list base.univariate/store=sashelp.tmplmst;
run;

/*selects, for listing, items that meet a particular condition*/
/*where=<expression>*/

/*
PATH | _PATH_
STORE
TYPE | _TYPE_: COLUMN
			   FOOTER
			   HEADER
			   LINK
			   STYLE
			   TABLE
			   TAGSET
NOTES
SIZE
CREATED
CDATE | _CDATE_
CDATETIME | _CDATETIME_
CTIME | _CTIME_
MDATE | _MDATE_
MDATETIME | _MDATETIME_
MODIFIED
MTIME | _MTIME_
*/

proc template;
	list/where=(path? 'Default');
run;
proc template;
	source / where=(lowcase(type) = 'tagset' && _path_ ? 'Default');
	list;
run;

proc template;
	source / where=(lowcase(label) ? 
                     'common matrix' && _type_ = 'Link'); 
	list;
run;

proc template;
	list / where=(size > 70000); 
run;

proc template;
	list / where=(datepart(created) = today());
run;

proc template;
	list / where=(_cdate_ < '16JUL2015'd); 
run;

*=========================================================================;
/*
PATH - Specifies locations to write to or read from when you create or use 
PROC TEMPLATE templates or definitions, and specifies the order in which to 
search for them. This statement overrides the ODS PATH statement for the 
duration of the PROC TEMPLATE step.
*/

/*PATH <(APPEND)( | PREPEND)( | REMOVE)> location(s);*/
/*PATH path-argument;*/

proc template;
	path show;
run;

proc template;
	path verify;
run;

proc template;
	path reset;
run;


proc template;
	path sashelp.tmplmst;
	list;
run;


*============================================================================;
/*SOURCE - Writes the source code for the template specified to the SAS log.*/
/*
options
EXPAND - prints the source of all parents of a template.

FILE - specifies a file to write the item to.

NOFOLLOW - specifies that the program does not resolve links in the 
			PARENT= statement, which specifies the item that the current 
			item inherits from.

STORE - specifies the template store where the item is located.

WHERE - selects items that meet a particular condition.
*/


proc template;
	source mygraphtemplate/expand;
run;

proc template;
	source mygraphtemplate/file="E:\NewDisk\SAS\My SAS\SAS Graph\Proc Template\Program\mygraphtemplate.sas";
run;

*==============================================================================;

/*TEST - Tests the most recently created item by binding it to the specified data set.*/

proc template;
	test data=sashelp.cars/store=sasuser.templat;
run;

/*NOTE: The most recent definition must be a TABLE definition! The test will not be run.*/
