/*Compound Statements*/

/*do statements syntax*/
/*
do ;
	statements ;
end ;
*/
/*nested do statements*/
/*
do;
	statements;
	do;
		statements;
	end;
	statements;
end;
*/


proc iml;
	reset printall;
	x = 5;
	y = 10;
	if x < y then 
		do;
			z1 = abs(x + y);
			z2 = abs(x - y);
		end;
	else 
		do;
			z1 = abs(x - y);
			z2 = abs(x + y);
		end;

/*	or*/
	if x < y then do;
		z1 = abs(x + y);
		z2 = abs(x - y);
	end;
	else do;
		z1 = abs(x - y);
		z2 = abs(x + y);
	end;
quit;	

