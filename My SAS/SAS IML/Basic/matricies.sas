/*Working with Matricies*/

/*Types of matrices*/

proc iml;
	options validvarname=any;
/*	Scalar matrix*/
	a = 23;
	b = 23.5;
	c = "Karthik";
	'my name'n = "Karthik";
	print a, b, c;
	print 'my name'n;
	
/*	row vector*/
	a = {1 2 3 4 5};
	b = {"K" "A" "R" "T" "H" "I"};
	print a,b;

/*	column vector*/
	a = {1, 2, 3, 4, 5};
	b = {"K" ,"A", "R", "T", "H", "I"};
	print a, b;

/*	2D matrices*/
	a = {1 2, 3 4, 5 6};
	b = {1 2 3, 4 5 6};
	c = {"K" "A", "R" "T", "H" "I"};
	d = {"K" "A" "R", "T" "H" "I"};
	print a, b, c, d;

/*	Missing values*/
	a = {1 ., 3 4, 5 6};
	b = {1 2 3, . 5 6};
	c = {"K" "", "R" "T", "H" "I"};
	d = {"K" "A" "R", "T" "" "I"};
	print a, b, c, d;
quit;



/*Example*/
proc iml;

/*
RESET PRINT statement produces output that includes the name of the matrix, its dimensions, 
its type, and (when the type is character) the element size of the matrix.
*/

/*
The element size represents the length of each string, and it is determined by the length of the longest string.
*/
	reset print;
	coffee = {4 2 2 3 2,
			  3 3 1 2 1,
	          2 1 0 2 1,
	          5 4 4 3 4};

	names = {Jenny, Linda, Jim, Samuel};


/*	rowname= - specifies row names*/
/*	format= - specifies formats*/
/*	label= - specifies label name*/

	print coffee[rowname=names];

	reset noprint;
	dayCost = 0.30 # coffee; /* elementwise multiplication */
	print dayCost[rowname=names format=8.2 label="Daily totals"];

	ones = {1,1,1,1,1};
	weektot = dayCost * ones; /* matrix-vector multiplication */
	print weektot[rowname=names format=8.2 label="Weekly totals"];

	col = ncol(coffee);
	grandtot = sum(coffee);
	average = grandtot / ncol(coffee);
	print col, grandtot[label="Total number of cups"],
	average[label="Daily average"];
quit;


/*Functions That Generate Matrices*/

/*
BLOCK 	- creates a block-diagonal matrix
DESIGNF - creates a full-rank design matrix
I 		- creates an identity matrix
J 		- creates a matrix of a given dimension
REPEAT 	- creates a new matrix by repeating elements of the argument matrix
SHAPE 	- shapes a new matrix from the argument
*/


proc iml;
	reset print;
/*	block statement*/
/*	BLOCK (matrix1,< matrix2,. . . ,matrix15 >) ;*/
	a = {1 1, 2 2};
	b = {3 3, 4 4};
	c = block(a,b);
/*	J statement*/
/*	J (nrow < ,ncol < ,value > >) ;*/

	d = j(5, 1, 1);
	e = j(5, 1);
	f = j(1, 5, 6);
	g = j(1, 5);

/*	I statement -  generateds identity matrix*/
/*	I (dimension) ;*/
	h = i(3);
	i = i(4);

/*	DESIGNF - generates a full-rank design matrix*/
/*	DESIGNF (column-vector) ;*/
/*	j = designf({1 1, 2 2, 3 3, 4 4});*/
	k = designf({1, 1, 1, 2, 2, 3, 3});
	l = design({1, 1, 1, 2, 2, 3, 3});

/*	REPEAT - creates new matrix by repeating elements of the argument matrix*/
/*	REPEAT (matrix, nrow, ncol) ;*/

	m = {1 2, 3 4};
	n = repeat(m, 2, 3);

/*	SHAPE - creates a new matrix by reshaping an argument matrix*/
/*	SHAPE (matrix, nrow < ,ncol < ,pad-value > >) ;*/
	o = shape({1 1, 2 2, 3 3}, 3, 3);
	p = shape({1 1, 2 2, 3 3}, 2, 3);
	q = shape({1 1, 2 2, 3 3}, 3, 3, 0);
quit;


/*Index vectors*/
/*Create row vectors*/

proc iml;
	reset print;
	a = 1 : 5;
	b = 10: 5;
	c = 'n1' : 'n6';
	d = do(-1,1,.5);
quit;


