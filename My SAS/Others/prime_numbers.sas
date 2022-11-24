data have;
	do i = 2 to 100;
		do j = 1 to i;
			n = mod(i, j);
			output;
		end;
	end;
run;

proc sql;
	create table want as
	select distinct i as prime_numbers from chk
		where n=0 group by i having count(n)=2;
quit;

