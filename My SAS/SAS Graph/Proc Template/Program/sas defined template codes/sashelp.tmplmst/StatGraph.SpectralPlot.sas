proc template;
	path sashelp.tmplmst;
	source StatGraph.SpectralPlot;
	define statgraph StatGraph.SpectralPlot;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay;
         		needleplot x=frequency y=spectrum / lineattrs=(color=graphdatadefault:contrastcolor);
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
