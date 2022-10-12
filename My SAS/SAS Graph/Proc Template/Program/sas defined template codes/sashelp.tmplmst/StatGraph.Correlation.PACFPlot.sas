proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.PACFPlot;
	define statgraph StatGraph.Correlation.PACFPlot;
		dynamic title series nlags _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5 0
         					 0.5 1)) label="PACF") xaxisopts=(linearopts=(integer=true) label="Lag");
         		bandplot limitlower=eval (-2*pacfstd(series, nlags=nlags)) limitupper=eval (
            			 2*pacfstd(series, nlags=nlags)) x=eval (lags(series,max=nlags)) / rolename=(
            			 xtipname=eval (lags(series,max=nlags)) lowertipname=eval (
            			-2*pacfstd(series, nlags=nlags)) uppertipname=eval (
            			 2*pacfstd(series, nlags=nlags))) tiplabel=(xtipname="Lag" lowertipname="Lower"
            			 uppertipname="Upper") tip=(xtipname lowertipname uppertipname) display=(fill)
            			 fillattrs=(color=graphconfidence:color) legendlabel="Two Standard Errors" name=
            			 "Conf";
         		needleplot x=eval (lags(series,max=nlags)) y=eval (pacf(series, nlags=nlags)) /
            			   rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
            			   pacf(series, nlags=nlags))) tiplabel=(xtipname="Lag" ytipname="PACF") tip=(
            			   xtipname ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         		discretelegend "Conf" /;
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
