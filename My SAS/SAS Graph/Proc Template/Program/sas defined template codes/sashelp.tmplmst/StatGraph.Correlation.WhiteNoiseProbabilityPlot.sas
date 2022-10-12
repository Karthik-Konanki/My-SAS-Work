proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.WhiteNoiseProbabilityPlot;
	define statgraph StatGraph.Correlation.WhiteNoiseProbabilityPlot;
		dynamic title series nlags nparms _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(linearopts=(integer=true) label="Lag") yaxisopts=(label=
	         				"White Noise Probabilities" linearopts=(viewmin=0 viewmax=1));
	        if (nparms > 0)
	        	bandplot y=eval (wnprob(series, nlags=nlags, nparms=nparms)) limitlower=0
	        		limitupper=nparms / display=(fill) datatransparency=0.5 extend=true fillattrs=
	                (color=graphconfidence2:color);
	        endif;
        		needleplot x=eval (lags(series,max=nlags)) y=eval (
            				wnprob(series, nlags=nlags, nparms=nparms)) / rolename=(xtipname=eval (
            				lags(series,max=nlags)) ytipname=eval (wnprob(series, nlags=nlags, nparms=nparms)
            				)) tiplabel=(xtipname="Lag" ytipname="White Noise Probability") tip=(xtipname
            				ytipname) lineattrs=(color=graphfit:contrastcolor thickness=8);
         		referenceline y=0.05 / legendlabel="5% Probability" name="Prob5";
         		referenceline y=0.01 / lineattrs=(pattern=GraphPredictionLimits:linestyle)
            				  legendlabel="1% Probability" name="Prob1";
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
