proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.StockingLevelPlot;
	define statgraph StatGraph.Forecast.StockingLevelPlot;
   		dynamic title time variable variablelabel id idlabel idformat idtype interval integertime
      			horizon base confidencelabel _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel=variable label=variablelabel display=all
         					griddisplay=auto_on) xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(integer=
         					integertime));
         		bandplot x=time limitupper=stockingupper limitlower=stockinglower / display=(fill)
            			 fillattrs=graphconfidence datatransparency=0.5 name="conf" legendlabel=
            			 confidencelabel;
         		scatterplot x=time y=actual / markerattrs=graphdatadefault name="actual" legendlabel
            				="actual";
         		seriesplot x=time y=stockingpredict / lineattrs=graphprediction (pattern=solid
            				thickness=1) name="predicted" legendlabel="predicted";
         		seriesplot x=time y=stockingerror / lineattrs=graphdata2 name="error" legendlabel=
            				"error";
         		referenceline y=base;
         		referenceline x=horizon / lineattrs=(pattern=dash);
         		discretelegend "actual" "predicted" "conf" "error" /;
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
