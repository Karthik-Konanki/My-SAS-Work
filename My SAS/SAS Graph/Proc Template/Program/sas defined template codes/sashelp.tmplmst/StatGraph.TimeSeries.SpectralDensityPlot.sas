proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.SpectralDensityPlot;
	define statgraph StatGraph.TimeSeries.SpectralDensityPlot;
   		dynamic title variable variablelabel pid pidlabel idformat idtype interval integertime x
      			series meanadj kernel cparm eparm weights seasonality _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="density" label="density" display=all
         					griddisplay=auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true)))
         					xaxisopts=(shortlabel=pid label=pidlabel type=idtype timeopts=(tickvalueformat=
         					idformat) display=all offsetmin=0.05 griddisplay=auto_on linearopts=(integer=
         					integertime));
         	if (n(eval(period(x))) > 75)
            	seriesplot x=eval (period(x)) y=eval (
               				spectrum(series, meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm,
 							weight=coln(weights))) / legendlabel="spectral density" name="density";
            	discretelegend "density";
         	else
            	seriesplot x=eval (period(x)) y=eval (
               				spectrum(series, meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm,
 							weight=coln(weights))) / display=all legendlabel="spectral density" name="density";
            	discretelegend "density";
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
