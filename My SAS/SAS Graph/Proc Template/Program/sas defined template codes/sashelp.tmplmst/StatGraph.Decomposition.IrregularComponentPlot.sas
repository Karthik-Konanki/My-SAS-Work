proc template;
	path sashelp.tmplmst;
	source StatGraph.Decomposition.IrregularComponentPlot;
	define statgraph StatGraph.Decomposition.IrregularComponentPlot;
		dynamic title time series seasonality mode integertime variable variablelabel id idlabel
				idformat idtype interval _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					 tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(integer=
         					 integertime)) yaxisopts=(display=all griddisplay=auto_on label="irregular");
         		seriesplot x=time y=eval (ic (series, seasonality=seasonality, mode=mode)) /
            			   rolename=(xtipname=time ytipname=eval (
            			   ic (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname="component")
            			   tip=(xtipname ytipname) lineattrs=graphfit;
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
