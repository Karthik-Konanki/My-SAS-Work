proc iml;
	w1 = "I said, ""Don't fall!""";
	w2 = 'I said, "Don''t fall!"';
	print w1 w2;
quit;


proc iml;
	w1 = "I said, ""Don't fall!""";
	w2 = 'I said, "Don''t fall!"';
	print w1;
	print w2;
quit;

/*Reassigning Values*/
proc iml;
	a = {1 2 3, 6 5 4};
	print a;
	a = {'Sales' 'Marketing' 'Administration'};
	print a;
quit;
