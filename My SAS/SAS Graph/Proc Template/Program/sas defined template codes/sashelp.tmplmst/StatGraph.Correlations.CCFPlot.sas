proc template;
	path sashelp.tmplmst;
	source StatGraph.Correlations.CCFPlot;
	define statgraph StatGraph.Correlations.CCFPlot;
   		dynamic title series crossseries nlags _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(linearopts=(viewmin=-1 viewmax=1 tickvaluelist=(-1 -0.5 0
         					0.5 1)) label="CCF") xaxisopts=(linearopts=(integer=true) label="Lag");
         		bandplot limitlower=eval (-2*ccfstd(series, crossseries,nlags=nlags)) limitupper=
            			 eval (2*ccfstd(series, crossseries,nlags=nlags)) x=eval (clags(series, max=nlags)
            			 ) / rolename=(xtipname=eval (clags(series, max=nlags)) lowertipname=eval (
            			-2*ccfstd(series, crossseries,nlags=nlags)) uppertipname=eval (
            			 2*ccfstd(series, crossseries,nlags=nlags))) tiplabel=(xtipname="Lag" lowertipName
            			="Lower" uppertipName="Upper") tip=(xtipname lowertipname uppertipname) display=(
            			fill) fillattrs=(color=graphconfidence:color) legendlabel="Two Standard Errors"
            			name="Conf";
         		needleplot x=eval (clags(series, max=nlags)) y=eval (
            				ccf(series, crossseries,nlags=nlags)) / rolename=(xtipname=eval (
            				clags(series, max=nlags)) ytipname=eval (ccf(series, crossseries,nlags=nlags)))
            				tiplabel=(xtipName="Lag" ytipName="CCF") tip=(xtipname ytipname) lineattrs=(color
            				=graphfit:contrastcolor thickness=8);
         		referenceline x=0 / lineattrs=graphaxislines;
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
