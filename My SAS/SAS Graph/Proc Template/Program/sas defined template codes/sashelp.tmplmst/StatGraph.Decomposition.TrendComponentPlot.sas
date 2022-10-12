proc template;
	path sashelp.tmplmst;
	source StatGraph.Decomposition.TrendComponentPlot;
	define statgraph StatGraph.Decomposition.TrendComponentPlot;
		dynamic title time series seasonality mode lambda integertime variable variablelabel id
      			idlabel idformat idtype interval _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
							tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(integer=
							integertime)) yaxisopts=(display=all griddisplay=auto_on label="trend");
				seriesplot x=time y=series / lineattrs=graphdatadefault legendlabel="original" name=
							"original";
				seriesplot x=time y=eval (tc (series, seasonality=seasonality, mode=mode)) /
							rolename=(xtipname=time ytipname=eval (
            				tc (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname="component")
            				tip=(xtipname ytipname) lineattrs=graphfit legendlabel="trend" name="trend";
         		discretelegend "original" "trend" /;
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
