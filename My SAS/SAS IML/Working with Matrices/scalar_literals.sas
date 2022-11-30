/*Scalar literals*/


proc iml;
	a = 5;
	a = 1.05
	a = .;
	a = 'Hello, World';
	print a;
quit;


proc iml;
	options validvarname=any;
	'my name'n = "Karthik";
	print 'my name'n;
quit;
