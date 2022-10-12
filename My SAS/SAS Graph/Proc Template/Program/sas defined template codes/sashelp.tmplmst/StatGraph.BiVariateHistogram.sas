proc template;
	path sashelp.tmplmst;
	source StatGraph.BiVariateHistogram;
	define statgraph statgraph.bivariatehistogram;
		dynamic _byline_ _bytitle_ _byfootnote_;
		begingraph;
			layout overlay3d;
				bihistogram3dparm x=histx y=histy z=histcount / fillattrs=(color=
            					graphdatadefault:color);
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
