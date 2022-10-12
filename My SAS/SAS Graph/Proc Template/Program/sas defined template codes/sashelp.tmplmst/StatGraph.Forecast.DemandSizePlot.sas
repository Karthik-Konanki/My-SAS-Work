proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.DemandSizePlot;
	define statgraph StatGraph.Forecast.DemandSizePlot;
   		dynamic title confidencelabel variable variablelabel _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(display=all griddisplay=auto_on linearopts=(integer=true))
         					 yaxisopts=(display=all griddisplay=auto_on label="demand sizes");
         		bandplot x=index limitupper=uppersize limitlower=lowersize / display=(fill)
            			 fillattrs=graphconfidence datatransparency=0.5 name="conf" legendlabel=
            			 confidencelabel;
         		seriesplot x=index y=predictedsize / lineattrs=graphprediction (pattern=solid
            				thickness=1) name="predicted" legendlabel="predicted" tip=(index actualsize
            				predictedsize);
         		scatterplot x=index y=actualsize / markerattrs=graphdatadefault name="actual"
            				legendlabel="actual" tip=(index actualsize predictedsize);
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
