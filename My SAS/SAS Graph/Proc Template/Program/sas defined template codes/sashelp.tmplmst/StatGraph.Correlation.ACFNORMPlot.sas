proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlation.ACFNORMPlot;
	define statgraph StatGraph.Correlation.ACFNORMPlot;
		dynamic title series nlags _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			Layout Overlay / yaxisopts=(label="Standardized ACF") xaxisopts=(linearopts=(integer=
        					 true) label="Lag");
        		bandplot limitlower=-2 limitupper=2 x=eval (lags(series,max=nlags)) / rolename=(
            			 xtipname=eval (lags(series,max=nlags))) tiplabel=(xtipname="Lag") tip=(xtipname)
            		 	 display=(fill) fillattrs=(color=GraphConfidence:color) datatransparency=0.5
            			 legendlabel="Two Standard Errors" name="Conf2" extend=true;
         		bandplot limitlower=-1 limitupper=1 x=eval (lags(series,max=nlags)) / rolename=(
            			 xtipname=eval (lags(series,max=nlags))) tiplabel=(xtipname="Lag") tip=(xtipname)
            			 display=(fill) fillattrs=(color=GraphConfidence:color) extend=true legendlabel=
            			 "One Standard Error" name="Conf1";
         		needleplot x=eval (lags(series,max=nlags)) y=eval (acfnorm(series, nlags=nlags)) /
            			   rolename=(xtipname=eval (lags(series,max=nlags)) ytipname=eval (
            				acfnorm(series, nlags=nlags))) tiplabel=(xtipName="Lag" ytipName=
            				"Standardized ACF") tip=(xtipName ytipName) lineattrs=(color=
            				GraphFit:contrastcolor thickness=8);
         		discretelegend "Conf1" "Conf2" /;
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
