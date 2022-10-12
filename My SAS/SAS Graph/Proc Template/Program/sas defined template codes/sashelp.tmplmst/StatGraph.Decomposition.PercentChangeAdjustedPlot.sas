proc template;
	path sashelp.tmplmst;
	source StatGraph.Decomposition.PercentChangeAdjustedPlot;
	define statgraph StatGraph.Decomposition.PercentChangeAdjustedPlot;
		dynamic title time series seasonality mode integertime variable variablelabel id idlabel
      			idformat idtype interval _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
							tickvalueformat=idformat) linearopts=(integer=integertime)) yaxisopts=(display=all
         					griddisplay=auto_on label="percent change adjusted");
         		needleplot x=time y=eval (pcsa (series, seasonality=seasonality, mode=mode)) /
            				rolename=(xtipname=time ytipname=eval (
            				pcsa (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
            				"component") tip=(xtipname ytipname) display=all lineattrs=graphdatadefault;
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
