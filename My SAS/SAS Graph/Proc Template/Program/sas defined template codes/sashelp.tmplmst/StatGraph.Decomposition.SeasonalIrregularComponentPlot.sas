proc template;
	path sashelp.tmplmst;
	source StatGraph.Decomposition.SeasonalIrregularComponentPlot;
	define statgraph StatGraph.Decomposition.SeasonalIrregularComponentPlot;
		dynamic Title Time Series Seasonality Mode IntegerTime Variable VariableLabel ID IDLabel
				IDFormat IDType Interval _byline_ _bytitle_ _byfootnote_;
		BeginGraph;
			EntryTitle TITLE;
			Layout Overlay / XAxisOpts=(shortlabel=ID label=IDLABEL type=IDTYPE timeopts=(
         					tickvalueformat=IDFORMAT) Display=all GridDisplay=Auto_On linearopts=(integer=
         					INTEGERTIME)) YAxisOpts=(Display=all GridDisplay=Auto_On label="Seasonal-Irregular");
         		SeriesPlot x=TIME y=eval (SIC (SERIES, SEASONALITY=SEASONALITY, MODE=MODE)) /
            				rolename=(xtipName=TIME ytipName=eval (
            				SIC (SERIES, SEASONALITY=SEASONALITY, MODE=MODE))) tiplabel=(ytipName="Component"
            				) tip=(xtipName ytipName) lineattrs=GRAPHDATADEFAULT LegendLabel=
            				"Seasonal-Irregular" name="SeasI";
         		SeriesPlot x=TIME y=eval (SC (SERIES, SEASONALITY=SEASONALITY, MODE=MODE)) /
            				rolename=(xtipName=TIME ytipName=eval (
            				SC (SERIES, SEASONALITY=SEASONALITY, MODE=MODE))) tiplabel=(ytipName="Component")
            				tip=(xtipName ytipName) lineattrs=GRAPHFIT LegendLabel="Seasonal" name="Seas";
         					DiscreteLegend "Seas" "SeasI" /;
      		EndLayout;
      		if (_BYTITLE_)
         		entrytitle _BYLINE_ / textattrs=GRAPHVALUETEXT;
      		else
         	if (_BYFOOTNOTE_)
            	entryfootnote halign=left _BYLINE_;
         	endif;
      		endif;
   		EndGraph;
	end;
run;
