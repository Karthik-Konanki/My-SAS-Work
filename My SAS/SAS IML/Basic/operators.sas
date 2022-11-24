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


/*Compound Expressions*/
proc iml;
	reset print;
	x = 3;
	y = 2;
	z = 4;
	a = x + y + z;
	b = x + Y*z;
	c = (-x)#(y-z);
quit;
