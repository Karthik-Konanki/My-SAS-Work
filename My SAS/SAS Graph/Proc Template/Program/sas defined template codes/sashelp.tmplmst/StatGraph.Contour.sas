proc template;
	path sashelp.tmplmst;
	source StatGraph.Contour;
	define statgraph StatGraph.Contour;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay;
         		contourplotparm x=densityx y=densityy z=densitycount / contourtype=fill nhint=10;
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
