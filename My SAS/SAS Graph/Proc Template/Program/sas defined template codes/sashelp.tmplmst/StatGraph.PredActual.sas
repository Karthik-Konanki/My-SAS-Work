proc template;
	path sashelp.tmplmst;
	source StatGraph.PredActual;
	define statgraph StatGraph.PredActual;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay / yaxisopts=(label="predicted and actual values");
         		bandplot limitlower=eval (predicted - tval * sqrt((1+leverage)*mse)) limitupper=eval
            			 (predicted + tval * sqrt((1+leverage)*mse)) x=id / display=(fill) fillattrs=(
            			 color=graphconfidence:color) legendlabel="95% confidence limits" name="conf";
         		seriesplot y=predicted x=id / lineattrs=(color=graphprediction:contrastcolor pattern
            			=graphprediction:linestyle) legendlabel="predicted" name="predicted";
         		scatterplot y=actual x=id / markerattrs=(size=graphdatadefault:markersize symbol=
            				graphdatadefault:markersymbol color=graphdatadefault:contrastcolor) legendlabel=
            				"actual" name="actual";
         		discretelegend "actual" "predicted" "conf";
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
