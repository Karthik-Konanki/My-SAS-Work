proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.DemandIntervalPlot;
	define statgraph StatGraph.Forecast.DemandIntervalPlot;
		dynamic title confidencelabel variable variablelabel _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(display=all griddisplay=auto_on linearopts=(integer=true))
         					 yaxisopts=(display=all griddisplay=auto_on label="demand intervals");
         		bandplot x=index limitupper=upperinterval limitlower=lowerinterval / display=(fill)
            			 fillattrs=graphconfidence datatransparency=0.5 name="conf" legendlabel=
            			 confidencelabel;
         		seriesplot x=index y=predictedinterval / lineattrs=graphprediction (pattern=solid
            				thickness=1) name="predicted" legendlabel="predicted" tip=(index actualinterval
            				predictedinterval);
         		scatterplot x=index y=actualinterval / markerattrs=graphdatadefault name="actual"
            				legendlabel="actual" tip=(index actualinterval predictedinterval);
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
