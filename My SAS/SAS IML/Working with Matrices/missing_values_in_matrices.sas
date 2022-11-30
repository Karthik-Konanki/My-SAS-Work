/*Missing values*/

proc iml;
	reset printall;
	x = {1 2 .,
		 . 5 6,
		 7 . 9};

	y = {4 . 2,
		 2 1 3,
		 6 . 5};

	a = x + y;
	
	b = x # y;

	c = x[+, ];

quit;

