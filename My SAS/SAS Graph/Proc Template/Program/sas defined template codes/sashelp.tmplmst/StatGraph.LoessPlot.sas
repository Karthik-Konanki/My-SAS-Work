proc template;
	path sashelp.tmplmst;
	source StatGraph.LoessPlot;
	define statgraph StatGraph.LoessPlot;
   		dynamic _byline_ _bytitle_ _byfootnote_;
   		begingraph;
    		layout overlay;
         		bandplot limitlower=lowercl limitupper=uppercl x=id / display=(fill) fillattrs=(
            				color=graphconfidence:color) legendlabel="95% cl's" name="conf";
         		seriesplot y=pred x=x / name="pred" lineattrs=(color=graphfit:contrastcolor pattern=
            				graphfit:linestyle thickness=graphfit:linethickness) legendlabel=
            				"loess fit curve";
         		scatterplot y=depvar x=x / markerattrs=(size=graphdatadefault:markersize symbol=
            				graphdatadefault:markersymbol color=graphdatadefault:contrastcolor);
         		discretelegend "pred" "conf" / halign=left valign=top;
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
