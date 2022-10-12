proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.CrossSeriesPlot;
	define statgraph StatGraph.TimeSeries.CrossSeriesPlot;
   		dynamic title time series crossseries variable variablelabel crossvariable crosslabel id
      			idlabel idformat idtype interval integertime shortvarlabel shortcrosslabel _byline_
      			_bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
		    layout overlay / yaxisopts=(shortlabel=shortvarlabel label=variablelabel display=all
		         			griddisplay=auto_on) y2axisopts=(shortlabel=shortcrosslabel label=crosslabel display
		         			=all griddisplay=auto_off) xaxisopts=(shortlabel=id label=idlabel type=idtype
		         			timeopts=(tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(
		         			integer=integertime));
		         seriesplot x=time y=series / legendlabel=variable lineattrs=graphdata1 name="series";
		         seriesplot x=time y=crossseries / yaxis=y2 lineattrs=graphdata2 legendlabel=
		            		crossvariable name="crossseries";
		         discretelegend "series" "crossseries";
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
