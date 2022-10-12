proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.SeriesPlot;
	define statgraph StatGraph.TimeSeries.SeriesPlot;
   		dynamic title time series integertime variable variablelabel id idlabel idformat idtype
      			interval _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel=variable label=variablelabel display=all
         					griddisplay=auto_on) xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(integer=
         					integertime));
         	if (n(series) > 75)
            	seriesplot x=time y=series;
         	else
            	seriesplot x=time y=series / display=all;
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
