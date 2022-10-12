proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.ErrorSpectralDensityPlot;
	define statgraph StatGraph.TimeSeries.ErrorSpectralDensityPlot;
   		dynamic title variable variablelabel fid fidlabel series meanadj kernel cparm eparm alpha
      			conflevel weights seasfreq tickvallist tickdisplist freqvallist freqdisplist maxfreq
      			_byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="density" label="density" display=all
         					griddisplay=auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true)))
         					xaxisopts=(shortlabel="period" label="period" type=linear display=all offsetmin=0.02
         					offsetmax=0.02 griddisplay=auto_on reverse=true linearopts=(tickdisplaylist=
         					tickdisplist tickvaluelist=tickvallist viewmin=0 viewmax=maxfreq)) x2axisopts=(
         					shortlabel="frequency" label="frequency" type=linear display=all offsetmin=0.02
         					offsetmax=0.02 griddisplay=auto_off reverse=true linearopts=(tickvaluelist=
         					freqvallist tickdisplaylist=freqdisplist viewmin=0 viewmax=maxfreq));
         	if (alpha > 0 and alpha < 1)
            if (exists(conflevel))
            	bandplot limitlower=eval (
                  		 spectrum_lower(series, meanadj=meanadj, kernel=kernel, cparm=cparm,
 						 eparm=eparm, weight=coln(weights), alpha=alpha) * spectrum(series,
 						 meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm, weight=coln(weights))) limitupper=
                  		 eval (
                  	  	 spectrum_upper(series, meanadj=meanadj, kernel=kernel, cparm=cparm,
 						 eparm=eparm, weight=coln(weights), alpha=alpha) * spectrum(series,
 					 	 meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm, weight=coln(weights))) x=eval (
            		ifn(2*constant('pi')/period(series),2*constant('pi')/period(series),0,0)) /
                  		 xaxis=x2 display=(fill) fillattrs=(color=graphconfidence:color) extend=true
                  		 legendlabel=conflevel name="conf" datatransparency=0.5 tiplabel=(x="freq"
                  		 limitupper="upper" limitlower="lower");
            else
               bandplot limitlower=eval (
                  		spectrum_lower(series, meanadj=meanadj, kernel=kernel, cparm=cparm,
 						eparm=eparm, weight=coln(weights), alpha=alpha) * spectrum(series,
 						meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm, weight=coln(weights))) limitupper=
                  		eval (
                  		spectrum_upper(series, meanadj=meanadj, kernel=kernel, cparm=cparm,
 						eparm=eparm, weight=coln(weights), alpha=alpha) * spectrum(series,
 						meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm, weight=coln(weights))) x=eval (
                  ifn(2*constant('pi')/period(series),2*constant('pi')/period(series),0,0)) /
                  		xaxis=x2 display=(fill) fillattrs=(color=graphconfidence:color) extend=true
                  		legendlabel="50% confidence" name="conf" datatransparency=0.5 tiplabel=(x=
                  		"freq" limitupper="upper" limitlower="lower");
            endif;
         	endif;
         		seriesplot x=eval (
            		ifn(2*constant('pi')/period(series),2*constant('pi')/period(series),0,0)) y=eval
            			(periodogram (series, meanadj=meanadj)) / xaxis=x2 legendlabel="periodogram" name
            			="period" tiplabel=(x="freq" y="i(f)");
         		seriesplot x=eval (
            		ifn(2*constant('pi')/period(series),2*constant('pi')/period(series),0,0)) y=eval
            			(
            			spectrum(series, meanadj=meanadj,kernel=kernel, cparm=cparm, eparm=eparm,
 						weight=coln(weights))) / xaxis=x2 lineattrs=graphfit2 (pattern=solid thickness=2)
            			legendlabel="spectral density" name="density" tiplabel=(x="freq" y="s(f)");
         	if (exists(seasfreq) & seasfreq >= 0)
            	referenceline x=seasfreq / xaxis=x lineattrs=(pattern=dash color=
               			graphreference:color) curvelabelattrs=(color=graphreference:color) legendlabel
               			="seasonality" name="season";
         	endif;
         	if (exists(seasfreq) & seasfreq < maxfreq)
            	discretelegend "period" "density" "conf" "season";
         	else
            	discretelegend "period" "density" "conf";
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
