/*Iteration Statements*/

/*
======================================================================================
Clause 															DO Statement
======================================================================================
DATA 															DO DATA statement
variable = start TO stop < BY increment > 						Iterative DO statement
WHILE(expression) 												DO WHILE statement
UNTIL(expression) 												DO UNTIL statement
======================================================================================
*/

/*DO DATA*/


proc iml;
	filename myfile 'E:\NewDisk\SAS\My SAS\SAS IML\mydata.txt';
	infile myfile;
	do data;
		input name $6. x y;
	end;

	close myfile;
quit;


/*Iterative DO Statements*/

/*DO variable=start TO stop <BY increment > ;*/

proc iml;
	reset printall;
	y = 0;
	do i = 1 to 10 by 2;
		y = y + i;
		print i;
	end;
quit;


/*DO WHILE Statements*/

/*DO WHILE expression ;*/

proc iml;
	reset printall;
	count=1;
	do while(count<5);
		count = count + 1;
	end;
quit;

proc iml;
	reset printall;
	count=5;
	do while(count<5);
		count = count + 1;
	end;
quit;		


/*DO UNTIL Statements*/

/*DO UNTIL expression ;*/

proc iml;
	reset printall;
	count=1;
	do until(count>5);
		count=count + 1;
	end;
quit;

