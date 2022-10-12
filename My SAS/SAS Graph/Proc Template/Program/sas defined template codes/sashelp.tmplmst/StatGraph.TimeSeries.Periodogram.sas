proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.Periodogram;
	define statgraph StatGraph.TimeSeries.Periodogram;
   		dynamic title variable variablelabel pid pidlabel idformat idtype interval integertime x
      			series meanadj seasonality _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="power" label="power" display=all griddisplay=
         					auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true))) xaxisopts=(
         					shortlabel=pid label=pidlabel type=idtype timeopts=(tickvalueformat=idformat)
         					display=all offsetmin=0.05 griddisplay=auto_on linearopts=(integer=integertime));
         	if (n(eval(period(x))) > 75)
            	seriesplot x=eval (period(x)) y=eval (periodogram (series, meanadj=meanadj)) /
               				legendlabel="periodogram" name="period";
         	else
            	seriesplot x=eval (period(x)) y=eval (periodogram (series, meanadj=meanadj)) /
               		display=all legendlabel="periodogram" name="period";
         	endif;
         	if (seasonality)
            	referenceline x=seasonality / lineattrs=(pattern=dash) curvelabel="seasonality"
               				curvelabellocation=inside;
         	endif;
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
