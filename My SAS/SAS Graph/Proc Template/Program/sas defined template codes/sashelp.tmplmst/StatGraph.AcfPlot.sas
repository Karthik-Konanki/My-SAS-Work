proc template;
	path sashelp.tmplmst;
	source StatGraph.AcfPlot;
	define statgraph StatGraph.AcfPlot;
		dynamic _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle "ACF Plot";
			layout overlay / xaxisopts=(linearopts=(integer=true)) yaxisopts=(linearopts=(viewmin=
         					-1 viewmax=1 tickvaluelist=(-1 0 1)));
				bandplot LimitUpper=eval (2*STDERR) LimitLower=eval (-2*STDERR) x=lag / display=(
            			 fill) fillattrs=(color=GraphConfidence:color) name="Error" legendLabel=
            			 "Two Standard Errors" modelname="ACF";
				NeedlePlot y=autocorrelation x=LAG / name="ACF" LegendLabel="ACF" lineattrs=(color=
            			   graphfit:contrastcolor);
         		discretelegend "acf" "error" / halign=right valign=top;
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
