/* Data Statement*/

/** Data statement without adataset name*/

data ;
	set sashelp.class;
run;

data ;
	set sashelp.class;
run;


data "E:\NewDisk\DriveF\sas\class3.sas7bdat";
	put _all_;
	set sashelp.class;
	put _all_;
run;
