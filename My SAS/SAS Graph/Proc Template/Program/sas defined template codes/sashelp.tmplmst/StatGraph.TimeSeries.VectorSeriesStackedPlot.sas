proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.VectorSeriesStackedPlot;
	define statgraph statgraph.timeseries.vectorseriesstackedplot;
   		dynamic title footnote time nvars integertime height id idlabel idformat idtype interval
      			_byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					tickvalueformat=idformat) linearopts=(integer=integertime)) yaxisopts=(display=none)
         					height=960;
         		seriesplot x=time y=eval (
            				scale(series, group=variablenumber, min=nvars-variablenumber,
 							max=nvars-variablenumber + 0.95)) / group=variable name="variable" index=variableindex tip=(
            				variable time series);
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
