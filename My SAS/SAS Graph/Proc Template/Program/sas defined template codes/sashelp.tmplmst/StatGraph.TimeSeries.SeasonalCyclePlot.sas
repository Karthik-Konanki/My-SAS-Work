proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.SeasonalCyclePlot;
	define statgraph StatGraph.TimeSeries.SeasonalCyclePlot;
   		dynamic title cycle season time series variable variablelabel seasonality _byline_
      			_bytitle_ _byfootnote_;
   		begingraph;
      	entrytitle title;
      		layout overlay / yaxisopts=(shortlabel=variable label=variablelabel display=all
         					griddisplay=auto_on) xaxisopts=(display=all griddisplay=auto_on linearopts=(integer=
         					yes));
         	if (seasonality > 75 | (n(series) / seasonality) > 25)
            	seriesplot x=season y=series / group=cycle rolename=(xtipname=time ytipname=
               				series seasontipname=season cycletipname=cycle) tip=(xtipname ytipname
               				seasontipname cycletipname);
         	else
            	seriesplot x=season y=series / group=cycle display=all rolename=(xtipname=time
               				ytipname=series seasontipname=season cycletipname=cycle) tip=(xtipname
               				ytipname seasontipname cycletipname) markerattrs=(symbol=
               				graphdatadefault:markersymbol size=graphdatadefault:markersize);
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
