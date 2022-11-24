/*Numeric literals*/

proc iml;
	a = {1 . 3 4 5}; /* 1 x 5 row vector */
	b = {1,2,3,4,5}; /* 4 x 1 column vector */
	c = 3#b; /* 3 times the vector y */
	d = {1 2, 3 4, 5 6}; /* 3 x 2 matrix */
	print a, b c d;
run; 
