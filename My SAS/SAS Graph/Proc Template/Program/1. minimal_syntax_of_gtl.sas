/*Minimal Syntax of GTL*/

Proc template; /*compiles and saves an ODS template*/
	define statgraph <template name>; /*template definition block, and specifies the template type and name*/
		begingraph;/*graph statement block*/
			layout <layout name>; /*outer graph layout block*/
				GTL statements;
			endlayout; /*termination command*/
		endgraph;/*termination command*/
	end;/*termination command*/
run;
