/*selection statements*/

/*IF-THEN/ELSE statement*/

/*
IF expression THEN statement1 ;
ELSE statement2 ;
*/

proc iml;
	reset printall;
	x = {8 10, 2 5};

	if min(x) < 5 
		then p=1;
	else p=0;
	print p;
quit;

/*nested if statements*/

proc iml;
	reset printall;
	x = 10;
	y = 5;
	w = 0;
	n = 1;
	if n > 0 then
		if x>y then w=x;
		else w=y;
quit;

proc iml;
	reset printall;
	x = {8 10, 2 5};
	y = {4 11, 3 2};

	if (x<y) then p = 1;
	else p=0;

	if all(x<y) then p=1;
	else p=0;

	if any(x<y) then p=1;
	else p=0;
quit;
