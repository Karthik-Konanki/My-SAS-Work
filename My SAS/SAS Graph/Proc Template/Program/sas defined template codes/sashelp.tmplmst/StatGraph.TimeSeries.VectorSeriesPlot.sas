proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.VectorSeriesPlot;
	define statgraph StatGraph.TimeSeries.VectorSeriesPlot;
   		dynamic title footnote time nvars integertime id idlabel idformat idtype interval _byline_
      			_bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					tickvalueformat=idformat) linearopts=(integer=integertime));
         		seriesplot x=time y=series / group=variable name="variable" index=variableindex tip=
            				(variable time series);
         	if (nvars < 9)
            	discretelegend "variable";
         	endif;
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
