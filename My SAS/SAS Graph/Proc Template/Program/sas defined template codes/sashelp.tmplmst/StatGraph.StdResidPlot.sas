proc template;
	path sashelp.tmplmst;
	source StatGraph.StdResidPlot;
	define statgraph StatGraph.StdResidPlot;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay / yaxisopts=(label="studentized residual");
         		bandplot limitupper=2 limitlower=-2 x=id / name="band1" display=(fill) fillattrs=(
            			 color=graphconfidence:color) legendlabel="95% confidence limits" extend=true;
         		needleplot y=eval (residual/sqrt((mse/weight)*(1-leverage))) x=id / name="needle1"
            				display=all markerattrs=(color=graphdatadefault:contrastcolor symbol=
            				graphdatadefault:markersymbol size=graphdatadefault:markersize) lineattrs=(color=
            				graphdatadefault:contrastcolor) legendlabel="studentized residual";
         		discretelegend "needle1" "band1";
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
