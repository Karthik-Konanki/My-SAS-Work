proc template;
	path sashelp.tmplmst;
	source StatGraph.ScatterPlot;
	define statgraph StatGraph.ScatterPlot;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay;
         		scatterplot x=x y=y;
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
