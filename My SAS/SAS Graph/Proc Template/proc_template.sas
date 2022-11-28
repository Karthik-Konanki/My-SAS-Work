/*Syntax*/
/*
proc template;

	define column column-path </ store=libref.template-store>;
		<column-attribute-1; <...column-attribute-n;>>
		statements
	end;

	define footer footer-path </ store=libref.template-store>;
		<footer-attribute-1; <...footer-attribute-n;>>
		statements
	end;

	define header template-name </ store=libref.template-store>;
		<header-attribute-1; <...header-attribute-n;>>
		statements
	end;

	define style style-path </ store=libref.template-store>;
		<parent= style-path;>
		statements
	end;

	define table table-path </ store=libref.template-store>;
		<table-attribute-1; <...table-attribute-n;>>
		statements
	end;

	define tagset tagset-path </ store=libref.template-store>;
	define event event-name;
		<event-attribute-1; <...event-attribute-n;>>
		statements
	end;

	define crosstabs table-path </ store=libref.template-store>;
		statements
	end;

	define statgraph graph-path </ store=libref.template-store>;
		statements
	end;

	delete template-path </ store=libref.template-store >;
	edit template-path-1 <as template-path-2> </ store=libref.template-store > ;
	statements-and-attributes
	end;
	link template-path-1 to template-path-2 </ options>;
	list <starting-path></ options>;
	path location(s);
	source template-path </ option(s)>;
	test data=data-set </ store=libref.template-store>;
run;
*/


