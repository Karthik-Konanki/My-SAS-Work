proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.JointSeriesPlot;
	define statgraph StatGraph.TimeSeries.JointSeriesPlot;
   		dynamic title footnote time series jointseries variable variablelabel jointvariable
      			jointlabel id idlabel idformat idtype interval integertime shortvarlabel _byline_
      			_bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel=shortvarlabel label=variablelabel display=all
         					griddisplay=auto_on) y2axisopts=(shortlabel=jointvariable label=jointlabel display=
         					all griddisplay=auto_off) xaxisopts=(shortlabel=id label=idlabel type=idtype
         					timeopts=(tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(
         					integer=integertime));
         		seriesplot x=time y=series / lineattrs=graphdata1 legendlabel=variable name="series";
         		seriesplot x=time y=jointseries / lineattrs=graphdata2 legendlabel=jointvariable
            				name="jointseries";
         		discretelegend "series" "jointseries";
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
