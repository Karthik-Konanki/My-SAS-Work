
proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.LatticePlot;
	define statgraph StatGraph.Correlation.LatticePlot;
		dynamic title series nlags nparms _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout lattice / columns=2 rowgutter=10 columngutter=10 shrinkfonts=true;
			layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5
            				 0 0.5 1)) label="ACF") xaxisopts=(linearopts=(integer=true) label="Lag");
            	Bandplot limitlower=eval (-2*acfstd(series, nlags=nlags)) limitupper=eval (
               			 2*acfstd(series, nlags=nlags)) x=eval (lags(series,max=nlags)) / rolename=(
               			 xtipname=eval (lags(series,max=nlags)) lowertipname=eval (
               			 -2*acfstd(series, nlags=nlags)) uppertipname=eval (
               			2*acfstd(series, nlags=nlags))) tiplabel=(xtipname="Lag" lowertipname="Lower"
               			uppertipname="Upper") tip=(xtipname lowertipname uppertipname) display=(fill)
               			fillattrs=(color=graphconfidence:color) legendlabel="Two Standard Errors" name
               			="Conf";
            	needleplot x=eval (lags(series,max=nlags)) y=eval (acf(series, nlags=nlags)) /
               				rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
               				acf(series, nlags=nlags))) tiplabel=(xtipname="Lag" ytipname="ACF") tip=(
               				xtipname ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         	endlayout;
         	layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5
            				0 0.5 1)) label="PACF") xaxisopts=(linearopts=(integer=true) label="Lag");
            	Bandplot limitlower=eval (-2*pacfstd(series, nlags=nlags)) limitupper=eval (
                		 2*pacfstd(series, nlags=nlags)) x=eval (lags(series,max=nlags)) / rolename=(
               			 xtipname=eval (lags(series,max=nlags)) lowertipname=eval (
               			 -2*pacfstd(series, nlags=nlags)) uppertipname=eval (
               			 2*pacfstd(series, nlags=nlags))) tiplabel=(xtipname="Lag" lowertipname="Lower"
               			 uppertipname="Upper") tip=(xtipname lowertipname uppertipname) display=(fill)
               			 fillattrs=(color=graphconfidence:color) legendlabel="Two Standard Errors" name
               			="Conf";
            	needleplot x=eval (lags(series,max=nlags)) y=eval (pacf(series, nlags=nlags)) /
                		   rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
               			   pacf(series, nlags=nlags))) tiplabel=(xtipname="Lag" ytipname="PACF") tip=(
               			   xtipname ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         	endlayout;
         	layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5
            				0 0.5 1)) label="IACF") XAxisOpts=(linearopts=(integer=true) label="Lag");
            	bandplot limitlower=eval (-2*iacfstd(series, nlags=nlags)) limitupper=eval (
               			 2*iacfstd(series, nlags=nlags)) x=eval (lags(series,max=nlags)) / rolename=(
               			 xtipname=eval (lags(series,max=nlags)) lowertipname=eval (
               			 -2*iacfstd(series, nlags=nlags)) uppertipname=eval (
               			 2*iacfstd(series, nlags=nlags))) tiplabel=(xtipname="Lag" lowertipname="Lower"
               			 uppertipname="Upper") tip=(xtipname lowertipname uppertipname) display=(fill)
               			 fillattrs=(color=graphconfidence:color) legendlabel="Two Standard Errors" name
               			 ="Conf";
            	needleplot x=eval (lags(series,max=nlags)) y=eval (iacf(series, nlags=nlags)) /
               			   rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
               			   iacf(series, nlags=nlags))) tiplabel=(xtipname="Lag" ytipName="IACF") tip=(
               			   xtipname ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         	endlayout;
         	layout overlay / yaxisopts=(label="White Noise Prob" linearopts=(tickvalueformat=
            				 logprob. viewmax=4 tickvaluelist=(0 1 1.30102999566398 2 3))) xaxisopts=(
            				 linearopts=(integer=true) label="Lag");
	            if (nparms > 0)
	            	bandplot y=eval (
	                		-log10(wnprob(series, nlags=nlags, nparms=nparms) max
	 						 ifn(missing(wnprob(series, nlags=nlags, nparms=nparms)),.,1e-4))) limitlower=0 limitupper=
	                  		 nparms / display=(fill) datatransparency=0.5 extend=true fillattrs=(color=
	                  		 graphconfidence2:color);
            	endif;
            	needleplot x=eval (lags(series,max=nlags)) y=eval (
               			   -log10(wnprob(series, nlags=nlags, nparms=nparms) max
 					ifn(missing(wnprob(series, nlags=nlags, nparms=nparms)),.,1e-4))) / rolename=(xtipname=eval
               				(lags(series,max=nlags)) ytipname=eval (
               				-log10(wnprob(series, nlags=nlags, nparms=nparms) max
 					ifn(missing(wnprob(series, nlags=nlags, nparms=nparms)),.,1e-4)))) tiplabel=(xtipname="Lag"
               				ytipname="Ljung-Box white-noise test p-value") tip=(xtipname ytipname)
               				tipformat=(ytipname=logprob.) lineattrs=(color=graphfit:contrastcolor
               				thickness=8);
            	referenceline y=1.30102999566398 / legendlabel="5% Probability" name="Prob5";
            	referenceline y=2 / lineattrs=(pattern=GraphConfidence:linestyle) legendlabel=
               		"1% Probability" name="Prob1";
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
