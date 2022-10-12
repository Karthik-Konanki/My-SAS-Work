proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.ACFPlot;
	define statgraph StatGraph.Correlation.ACFPlot;
   		dynamic title series nlags _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      			Layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5 0
         						 0.5 1)) label="ACF") xaxisopts=(linearopts=(integer=true) label="Lag");
         			bandplot limitlower=eval (-2*acfstd(series, nlags=nlags)) limitupper=eval (
            				 2*acfstd(series, nlags=nlags)) x=eval (lags(series,max=nlags)) / rolename=(
            				xtipname=eval (lags(series,max=nlags)) lowertipname=eval (
            				-2*acfstd(series, nlags=nlags)) uppertipname=eval (2*acfstd(series, nlags=nlags))
            				) tiplabel=(xtipname="Lag" lowertipname="Lower" uppertipname="Upper") tip=(
            				xtipname lowertipname uppertipname) display=(fill) fillattrs=(color=
            				graphconfidence:color) legendlabel="Two Standard Errors" name="Conf";
         			needleplot x=eval (lags(series,max=nlags)) y=eval (acf(series, nlags=nlags)) /
            				   rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
            				   acf(series, nlags=nlags))) tiplabel=(xtipname="Lag" ytipname="ACF") tip=(xtipname
            				   ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         			DiscreteLegend "Conf" /;
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
