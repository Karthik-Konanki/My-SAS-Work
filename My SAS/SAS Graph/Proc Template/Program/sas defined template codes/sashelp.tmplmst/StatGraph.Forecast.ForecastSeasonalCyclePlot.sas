proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.ForecastSeasonalCyclePlot;
	define statgraph StatGraph.Forecast.ForecastSeasonalCyclePlot;
   		dynamic title Cycle Season Time Variable VariableLabel ID IDLabel IDFormat Interval
      			Seasonality _byline_ _bytitle_ _byfootnote_;
   		BeginGraph;
      		EntryTitle TITLE;
      		Layout Overlay / YAxisOpts=(shortlabel=VARIABLE label=VARIABLELABEL display=all
         					gridDisplay=auto_on) XAxisOpts=(display=all gridDisplay=auto_on linearopts=(Integer=
         					Yes));
         	if (SEASONALITY > 75 | (N(ACTUAL) + N(PREDICT) / SEASONALITY) > 25)
            	SeriesPlot x=SEASON y=ACTUAL / group=CYCLE lineattrs=GRAPHDATADEFAULT tip=(Cycle
               				Season Time Actual);
         	else
            	SeriesPlot x=SEASON y=ACTUAL / group=CYCLE display=ALL markerattrs=
               				GRAPHDATADEFAULT lineattrs=GRAPHDATADEFAULT tip=(Cycle Season Time Actual);
         	endif;
         	if (SEASONALITY > 75 | (N(ACTUAL) + N(PREDICT) / SEASONALITY) > 25)
            	SeriesPlot x=SEASON y=PREDICT / group=CYCLE lineattrs=GRAPHPREDICTION (pattern=
               				solid thickness=2) tip=(Cycle Season Time Predict);
         	else
            	SeriesPlot x=SEASON y=PREDICT / group=CYCLE display=ALL markerattrs=(color=
               				GraphPrediction:contrastcolor symbol=GraphPrediction:markersymbol size=
               				GraphPrediction:markersize) lineattrs=GRAPHPREDICTION (pattern=solid thickness
               				=2) tip=(Cycle Season Time Predict);
         	endif;
      		EndLayout;
      		if (_BYTITLE_)
         		entrytitle _BYLINE_ / textattrs=GRAPHVALUETEXT;
      		else
         	if (_BYFOOTNOTE_)
            	entryfootnote halign=left _BYLINE_;
         	endif;
      		endif;
   		EndGraph;
	end;
run;
