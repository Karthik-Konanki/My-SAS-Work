proc template;
	path sashelp.tmplmst;
	source StatGraph.Decomposition.LatticePlot;
	define statgraph StatGraph.Decomposition.LatticePlot;
		dynamic title time series seasonality mode integertime id idlabel idformat idtype interval
				_byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout lattice / columns=2 rowgutter=10 columngutter=10 shrinkfonts=true;
 			layout overlay / xaxisopts=(type=idtype timeopts=(tickvalueformat=idformat) display=
            				(line ticks tickvalues) griddisplay=auto_on linearopts=(integer=integertime))
            				yaxisopts=(display=all griddisplay=auto_on label="trend-cycle");
            	seriesplot x=time y=series / lineattrs=graphdatadefault;
            	seriesplot x=time y=eval (tcc (series, seasonality=seasonality, mode=mode)) /
               				rolename=(xtipname=time ytipname=eval (
               				tcc (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
               				"component") tip=(xtipname ytipname) lineattrs=graphfit;
         	endlayout;
         	layout overlay / xaxisopts=(type=idtype timeopts=(tickvalueformat=idformat) display=
            				(line ticks tickvalues) griddisplay=auto_on linearopts=(integer=integertime))
            				yaxisopts=(display=all griddisplay=auto_on label="seasonal-irregular");
            	seriesplot x=time y=eval (sic (series, seasonality=seasonality, mode=mode)) /
               				rolename=(xtipname=time ytipname=eval (
               				sic (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
               				"component") tip=(xtipname ytipname) lineattrs=graphfit;
            	seriesplot x=time y=eval (sc (series, seasonality=seasonality, mode=mode)) /
               				rolename=(xtipname=time ytipname=eval (
               				sc (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
               				"component") tip=(xtipname ytipname) lineattrs=graphdatadefault;
         	endlayout;
         	layout overlay / xaxisopts=(type=idtype timeopts=(tickvalueformat=idformat) display=
            				(line ticks tickvalues) griddisplay=auto_on linearopts=(integer=integertime))
            				yaxisopts=(display=all griddisplay=auto_on label="irregular");
            	seriesplot x=time y=eval (ic (series, seasonality=seasonality, mode=mode)) /
               				rolename=(xtipname=time ytipname=eval (
               				ic (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
               				"component") tip=(xtipname ytipname) lineattrs=graphfit;
         	endlayout;
         	layout overlay / xaxisopts=(type=idtype timeopts=(tickvalueformat=idformat) display=
            				(line ticks tickvalues) griddisplay=auto_on linearopts=(integer=integertime))
            				yaxisopts=(display=all griddisplay=auto_on label="seasonally adjusted");
            	seriesplot x=time y=series / lineattrs=graphdatadefault;
            	seriesplot x=time y=eval (sa (series, seasonality=seasonality, mode=mode)) /
               				rolename=(xtipname=time ytipname=eval (
               				sa (series, seasonality=seasonality, mode=mode))) tiplabel=(ytipname=
               				"component") tip=(xtipname ytipname) lineattrs=graphfit;
         	endlayout;
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
