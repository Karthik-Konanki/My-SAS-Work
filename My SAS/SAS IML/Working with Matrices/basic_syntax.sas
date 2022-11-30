/*Basic syntax*/


proc iml <symsize=n1> <worksize=n2>;
	<SAS/IML statements>;
quit;

/*
symsize = specifies the size of memory, in kilobytes, that is allocated to the PROC IML symbol space.

worksize = specifies the size of memory, in kilobytes, that is allocated to the PROC IML workspace.

If you do not specify any options, PROC IML uses host-dependent defaults. In general, you do not need 
to be concerned with the details of memory usage because memory allocation is done automatically.

*/

