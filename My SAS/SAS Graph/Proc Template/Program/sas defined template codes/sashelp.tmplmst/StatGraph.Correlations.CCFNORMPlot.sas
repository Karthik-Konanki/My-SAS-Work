
proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlations.CCFNORMPlot;
	define statgraph StatGraph.Correlations.CCFNORMPlot;
		dynamic title series crossseries nlags _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / yaxisopts=(label="Standardized CCF") xaxisopts=(linearopts=(integer=
         					 true) label="Lag");
				bandplot limitlower=-2 limitupper=2 x=eval (clags(series, max=nlags)) / rolename=(
            			 xtipname=eval (clags(series, max=nlags))) tiplabel=(xtipname="Lag") tip=(xtipname
            			 ) display=(fill) fillattrs=(color=graphconfidence:color) datatransparency=0.5
            			 legendlabel="Two Standard Errors" name="Conf2" extend=true;
         		bandplot limitlower=-1 limitupper=1 x=eval (clags(series, max=nlags)) / rolename=(
            			 xtipname=eval (clags(series, max=nlags))) tiplabel=(xtipname="Lag") tip=(xtipname
            			 ) display=(fill) fillattrs=(color=graphconfidence:color) extend=true legendlabel=
            			 "One Standard Error" name="Conf1";
         		needleplot x=eval (clags(series, max=nlags)) y=eval (
            			 ccfnorm(series, crossseries,nlags=nlags)) / rolename=(xtipname=eval (
            			 clags(series, max=nlags)) ytipname=eval (ccfnorm(series, crossseries,nlags=nlags)
            			 )) tiplabel=(xtipname="Lag" ytipname="Standardized CCF") tip=(xtipname ytipname)
            			 name="CCF" legendLabel="Standardized CCF" lineattrs=(color=graphfit:contrastcolor
            			 thickness=8);
         		referenceline x=0 / lineattrs=graphaxislines;
         		DiscreteLegend "Conf1" "Conf2" /;
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
