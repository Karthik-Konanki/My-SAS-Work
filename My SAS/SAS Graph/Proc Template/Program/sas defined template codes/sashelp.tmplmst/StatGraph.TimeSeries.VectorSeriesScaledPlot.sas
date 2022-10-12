proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.VectorSeriesScaledPlot;
	define statgraph StatGraph.TimeSeries.VectorSeriesScaledPlot;
   		dynamic title footnote time nvars integertime id idlabel idformat idtype interval _byline_
      			_bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout gridded;
         	layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
            				tickvalueformat=idformat) linearopts=(integer=integertime)) yaxisopts=(display=
            				none);
            	seriesplot x=time y=eval (scale(series, group=variablenumber, min=0, max=1)) /
               				group=variable name="variable" index=variableindex rolename=(xtipname=time
               				ytipname=eval (scale(series, group=variablenumber, min=0, max=1))) tiplabel=(
               				ytipname="series") tip=(variable time series);
           	if (nvars < 9)
               discretelegend "variable";
            endif;
         	endlayout;
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
