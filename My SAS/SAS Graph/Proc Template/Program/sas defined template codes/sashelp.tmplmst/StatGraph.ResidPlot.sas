proc template;
	path sashelp.tmplmst;
	source StatGraph.ResidPlot;
	define statgraph statgraph.residplot;
		dynamic _byline_ _bytitle_ _byfootnote_;
		begingraph;
			layout overlay / yaxisopts=(label="residual");
				bandplot limitupper=eval (3 * sqrt((mse/weight)*(1-leverage))) limitlower=eval (
            			 -3 * sqrt((mse/weight)*(1-leverage))) x=id / display=(fill) fillattrs=(color=
            			 graphconfidence:color);
         		needleplot y=residual x=id / lineattrs=(color=graphdatadefault:contrastcolor)
            			   display=all markerattrs=(color=graphdatadefault:contrastcolor symbol=
            		       graphdatadefault:markersymbol size=graphdatadefault:markersize);
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
