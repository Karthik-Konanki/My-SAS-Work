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

/* jenner-check note: original opened this section with a DO DATA block that
   read from a hardcoded local path (E:\NewDisk\SAS\My SAS\SAS IML\mydata.txt)
   via FILENAME/INFILE; omitted here since there's no portable stand-in file,
   the rest of the file (Iterative DO, DO WHILE, DO UNTIL) is unmodified. */

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
