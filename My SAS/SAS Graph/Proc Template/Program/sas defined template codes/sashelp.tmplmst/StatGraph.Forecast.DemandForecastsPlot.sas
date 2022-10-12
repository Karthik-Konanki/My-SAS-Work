proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.DemandForecastsPlot;
	define statgraph StatGraph.Forecast.DemandForecastsPlot;
		dynamic title confidencelabel variable variablelabel _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(display=all griddisplay=auto_on linearopts=(integer=true))
							yaxisopts=(display=all griddisplay=auto_on label="demand per period");
				bandplot x=index limitupper=upper limitlower=lower / display=(fill) fillattrs=
						graphconfidence datatransparency=0.5 name="conf" legendlabel=confidencelabel;
				scatterplot x=index y=actual / markerattrs=graphdatadefault name="actual"
						legendlabel="actual" tip=(index actual predict lower upper);
				seriesplot x=index y=predict / lineattrs=graphprediction (pattern=solid thickness=1)
						name="predicted" legendlabel="predicted" tip=(index actual predict lower upper);
				discretelegend "actual" "predicted" "conf" /;
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
