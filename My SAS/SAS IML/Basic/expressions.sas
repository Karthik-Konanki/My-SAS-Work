/*Functions as Expressions*/

proc iml;
	x = 36;
	y = {2 3, 4 5};
	a = sqrt(x);
	b = inv(y);
	c = rank(y);
	print x, y, a, b, c;
quit;


/*Operators as Expression*/

/*
1. prefix operators
2. binary operators
3. postfix operators
*/

proc iml;
	x = 5;
	y = x#(x>0);
	print x, y;
quit;


