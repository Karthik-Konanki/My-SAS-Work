/*Operators*/
/*
prefix operator

binary operator

postfix operator
*/
/*
Priority Group                          Operators
==============================================================================
I (highest) 		ˆ		`		subscripts		-(prefix)		##		**
II 					* 		# 		<> 				>< 				/ 		@
III 				+ 		-
IV 					||		//		:
V 					<		<=		> 				>= 				= 		^=
VI 					&
VII (lowest) 		|

*/

/*

The currently available operators categorized by function, are as follows:
addition operator						:   +
comparison operators					: 	<,   <=,   >,   >=,   =,   ^=
concatenation operator, horizontal		:   ||
concatenation operator, vertical		:   //
direct product operator					:   @
division operator						:   /
element maximum operator				:   <>
element minimum operator				:   ><
index creation operator					:   :
logical operators						:   &,   |,   ^
multiplication operator, elementwise	:   #
multiplication operator, matrix			:   *
power operator, elementwise				:   ##
power operator, matrix					:   **
sign reversal operator					:   –
subscripts								:   [ ]
subtraction operator					:   –
transpose operator						:  `
*/


/*Compound Expressions*/
proc iml;
	reset print;
	x = 3;
	y = 2;
	z = 4;
	a = x + y + z;
	b = x + Y*z;
	c = (-x)#(y-z);
	d = x + Y#z;
	e = x/y/z;
	f = x/(y/z);
	g = -x**2;
quit;



/*Elementwise Binary Operators*/
/*
======================================================
Operator 				Description
======================================================
+						Addition; string concatenation
- 						Subtraction
# 						Elementwise multiplication
## 						Elementwise power
/ 						Division
<> 						Element maximum
>< 						Element minimum
| 						Logical OR
& 						Logical AND
< 						Less than
<= 						Less than or equal to
> 						Greater than
>= 						Greater than or equal to
^= 						Not equal to
= 						Equal to
======================================================
*/


proc iml;
	reset printall;
	x = {2 2, 3 4};
	y = {4 5, 1 0};
	
	a = x + y;

	b = x - y;

	c = x # y;

	d = x ## y;

	e = x # 2;

	f = x <> y;

	g = x >< y;

	h = x <= y;

	i = x # (x>0);
quit;

*====================================================================;
/*
SUBSCRIPTS - Subscript operations have the general form operand[row,column]

	operand - is usually a matrix name, but it can also be an expression or literal.
	row - refers to a scalar or vector expression that selects one or more rows from the operand.
	column - refers to a scalar or vector expression that selects one or more columns from the operand.
*/

proc iml;
	reset printall;
	x = {1 2 3 4, 4 5 6 7, 7 8 9 0, 1 2 3 4};
	names={jenny, linda, jim, samuel};
	print x[rowname=names];
	y = x[4,3];
	mattrib x rowname=names colname={'Mon' 'Tue' 'Wed' 'Thu'};

/*	print x['jenny', 'Wed'];*/

	z=x[16];

/*	selecting row*/
	z1 = x['jenny',];
/*	selecting Column*/
	z2 = x[,'Mon'];


/*	Submatrices*/

	z3=x[{1 3}, {2 3 4}];

/*	Vector indices*/

	rows={1 3};
	columns={2 3 4};

	z4=x[rows, columns];


/*	Selecting Multiple Elements*/

	h = loc(x > 2);

	z5 = x[h];

	v = {-1 2 5 -2 7};
	v2 = v[{1 3 5}];
	v3 = v[,{1 3 5}];

/*	Subscripted Assignment*/
	x[1,2]=4;

quit;



proc iml;
	t = {3 2 -1,
		 6 -4 3,
		 2 2 2 };
	i = loc(t<0);
	print i;
	t[i] = 0;
	print t;
/*	or*/
	t[loc(t<0)] = 0;

	print t;
quit;

*==========================================================================;

/*Subscript Reduction Operators*/
/*
A reduction operator is a statistical operation (for example, a sum or a mean) that returns a matrix of a
smaller dimension.
========================================
Operator 				Description
========================================
+ 						Addition
# 						Multiplication
<> 						Maximum
>< 						Minimum
<:> 					Index of maximum
>:< 					Index of minimum
: 						Mean
## 						Sum of squares
========================================
*/

proc iml;
	coffee={4 2 2 3 2, 
			3 3 1 2 1, 
			2 1 0 2 1, 
			5 4 4 3 4};
	names={Jenny, Linda, Jim, Samuel};
	mattrib coffee rowname=names colname={'MON' 'TUE' 'WED' 'THU' 'FRI'};
	Total = coffee[,+];
	print coffee Total;
quit;


proc iml;
	reset printall;
	x = {2 3 4, 
		 1 0 5, 
		 8 7 9};

	y = x[{2 3}, +];

	y1 = x[+, <>];

	y2 = x[<>, +];

	y3 = x[,><][+];

	y4 = x[,<:>];

	y5 = x[>:<,];

	y6 = x[:];
quit;
