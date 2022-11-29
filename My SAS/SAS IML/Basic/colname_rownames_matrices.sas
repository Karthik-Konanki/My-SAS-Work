/*Displaying Matrices with Row and Column Headings*/

/*AUTONAME*/
/*COLNAME*/
/*ROWNAME*/

proc iml;

/*	AUTONAME statement*/
	x={4 2 2 3 2, 
	   3 3 1 2 1, 
       2 1 0 2 1, 
       5 4 4 3 4};

	reset autoname;
	print x;

/*	COLNAME and ROWNAME statements*/
	y = x;
	names={Jenny, Linda, Jim, Samuel};
	days={Mon Tue Wed Thu Fri};

	print y[rowname=names colname=days];

/*	MATTRIB statement*/
	mattrib y rowname=names colname=days label='Weekly Coffee' format=2.0;

	print y;
quit;
