proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.WhiteNoiseLogProbabilityPlot;
	define statgraph StatGraph.Correlation.WhiteNoiseLogProbabilityPlot;
   		dynamic title series nlags nparms _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(linearopts=(integer=true) label="Lag") yaxisopts=(label=
         					"White Noise Probabilities" linearopts=(tickvalueformat=logprob. viewmax=4
         					tickvaluelist=(0 1 1.30102999566398 2 3)));
         		if (nparms > 0)
            	bandplot y=eval (
               			-log10(wnprob(series, nlags=nlags, nparms=nparms) max
 				ifn(missing(wnprob(series, nlags=nlags, nparms=nparms)),.,1e-4))) limitlower=0 limitupper=
               				nparms / display=(fill) datatransparency=0.5 extend=true fillattrs=(color=
               				graphconfidence2:color);
         		endif;
         		needleplot x=eval (lags(series,max=nlags)) y=eval (
            			   -log10(wnprob(series, nlags=nlags, nparms=nparms) max ifn(missing(wnprob(series,
 							nlags=nlags, nparms=nparms)),.,1e-4))) / rolename=(xtipname=eval (lags(series,max=nlags))
            				ytipname=eval (
            			   -log10(wnprob(series, nlags=nlags, nparms=nparms) max ifn(missing(wnprob(series,
 							nlags=nlags, nparms=nparms)),.,1e-4)))) tiplabel=(xtipname="Lag" ytipname=
            				"Ljung-Box white-noise test p-value") tip=(xtipname ytipname) tipformat=(ytipname
            				=logprob.) lineattrs=(color=graphfit:contrastcolor thickness=8);
		        referenceline y=1.30102999566398 / legendlabel="5% Probability" name="Prob5";
		        referenceline y=2 / lineattrs=(pattern=graphpredictionlimits:linestyle) legendlabel=
            			"1% Probability" name="Prob1";
         		discretelegend "Prob5" "Prob1";
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
