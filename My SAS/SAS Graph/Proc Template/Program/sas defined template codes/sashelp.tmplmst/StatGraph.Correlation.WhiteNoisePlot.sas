proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.WhiteNoisePlot;
	define statgraph StatGraph.Correlation.WhiteNoisePlot;
   		dynamic title series nlags nparms _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(linearopts=(integer=true) label="Lag") yaxisopts=(label=
         					"White Noise Statistics");
         	if (nparms > 0)
	            bandplot y=eval (wn(series, nlags=nlags, nparms=nparms)) limitlower=0 limitupper=
	               nparms / display=(fill) datatransparency=0.5 extend=true fillattrs=(color=
	               graphconfidence2:color);
         	endif;
         	needleplot x=eval (lags(series,max=nlags)) y=eval (
            			wn(series, nlags=nlags, nparms=nparms)) / rolename=(xtipname=eval (
            			lags(series,max=nlags)) ytipname=eval (wn(series, nlags=nlags, nparms=nparms)))
            			tiplabel=(xtipname="Lag" ytipname="White Noise Statistics") tipformat=(ytipname=
            			logprob.) tip=(xtipname ytipname) lineattrs=(color=graphfit:contrastcolor
            			thickness=8);
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
