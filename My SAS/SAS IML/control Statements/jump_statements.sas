/*Jump Statements*/

/*GOTO label ;*/


proc iml;
	x = -10;
	do;
		if x < 0 then goto negative;
		y = sqrt(x);
		print y;
		goto TheEnd;
	negative:
		print "It's a negative number";
	TheEnd:
	end;
/*************************************/
	if x<0 then print "It's a negative number";
	else do;
		y = sqrt(x);
		print y;
	end;
quit;

/*LINK label ;*/

proc iml;
	x = -10;
	do;
		if x < 0 then link negative;
		y = sqrt(x);
		print y;
		goto TheEnd;
	negative:
		print "It's a negative number";
		x = abs(x);
		return;
	TheEnd:
	end;
quit;


