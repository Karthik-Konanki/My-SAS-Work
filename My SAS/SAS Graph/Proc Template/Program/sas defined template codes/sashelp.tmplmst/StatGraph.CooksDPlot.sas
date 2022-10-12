proc template;
	path sashelp.tmplmst;
	source StatGraph.CooksDPlot;
	define statgraph StatGraph.CooksDPlot;
   		dynamic _byline_ _bytitle_ _byfootnote_;
		begingraph;
			layout overlay / yaxisopts=(label="Cook's D");
         		needleplot y=eval (
            				(residual*residual)/((mse/weight)*(1-leverage))*leverage/(1-leverage)/df) x=id /
            				name="needle1" display=ALL markerattrs=(symbol=GraphDataDefault:markersymbol size
            				=GraphDataDefault:markersize color=GraphDataDefault:contrastcolor) lineattrs=(
            				color=GraphDataDefault:contrastcolor) legendlabel="Cook's D Statistic";
         		referenceline y=eval (4/nobs) / name="line1" lineattrs=(color=GraphFit:contrastcolor
            					) legendlabel="95% Confidence Limit";
         		discretelegend "needle1" "line1";
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
