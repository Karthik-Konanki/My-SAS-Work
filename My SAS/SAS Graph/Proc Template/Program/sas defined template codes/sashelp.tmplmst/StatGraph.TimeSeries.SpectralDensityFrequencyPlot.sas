proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.SpectralDensityFrequencyPlot;
	define statgraph StatGraph.TimeSeries.SpectralDensityFrequencyPlot;
   		dynamic title variable variablelabel fid fidlabel idformat idtype interval integertime x
      			series meanadj kernel cparm eparm weights alpha conflevel _byline_ _bytitle_
      			_byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="density" label="density" display=all
         					griddisplay=auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true)))
         					xaxisopts=(shortlabel=fid label=fidlabel type=idtype timeopts=(tickvalueformat=
         					idformat) display=all offsetmin=0.05 griddisplay=auto_on linearopts=(tickvaluelist=(
         					0 0.79 1.57 2.36 3.14) tickdisplaylist=("0" "(*ESC*){unicode pi}/4"
         					"(*ESC*){unicode pi}/2" "3(*ESC*){unicode pi}/4" "(*ESC*){unicode pi}")));
         		bandplot limitlower=eval (
            				spectrum_lower(series, meanadj=meanadj, kernel=kernel, cparm=cparm, eparm=eparm,
 							weight=coln(weights), alpha=alpha) * spectrum(series, meanadj=meanadj,kernel=kernel,
 							cparm=cparm, eparm=eparm, weight=coln(weights))) limitupper=eval (
            				spectrum_upper(series, meanadj=meanadj, kernel=kernel, cparm=cparm, eparm=eparm,
 							weight=coln(weights), alpha=alpha) * spectrum(series, meanadj=meanadj,kernel=kernel,
 							cparm=cparm, eparm=eparm, weight=coln(weights))) x=eval (
            				ifn(2*constant('pi')/period(x),2*constant('pi')/period(x),0,0)) / display=(fill)
            				fillattrs=graphconfidence extend=true legendlabel=conflevel name="conf" tiplabel=
            				(x="freq" limitlower="lower" limitupper="upper");
         		seriesplot x=eval (ifn(2*constant('pi')/period(x),2*constant('pi')/period(x),0,0)) y
            				=eval (
            				spectrum(series, meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm,
 							weight=coln(weights))) / legendlabel="spectral density" name="density" primary=true tiplabel
            				=(x="freq");
         		discretelegend "density" "conf";
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
