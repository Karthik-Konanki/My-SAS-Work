proc template;
	path sashelp.tmplmst;
	source StatGraph.Bivariate;
	define statgraph statgraph.bivariate;
		dynamic _byline_ _bytitle_ _byfootnote_;
		begingraph;
 			layout overlay3d;
				bihistogram3dparm x=histx y=histy z=histcount / fillattrs=(color=
            					  graphdatadefault:color);
				surfaceplotparm x=densityx y=densityy z=densitycount / fillattrs=(color=
								graphcondfidence:color) datatransparency=0.5;
			endlayout;
			if (_bytitle_)
				entrytitle _byline_ / textattrs=graphvaluetext;
			else
			if (_byfootnote_)
				entryfootnote halign=left _byline_;
			endif;
			endif;
		endgraph;
	end;
run;
