proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.ErrorPeriodogram;
	define statgraph StatGraph.TimeSeries.ErrorPeriodogram;
   		dynamic title variable variablelabel fid fidlabel series meanadj seasfreq tickvallist
      			tickdisplist freqvallist freqdisplist maxfreq _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="power" label="power" display=all griddisplay=
         					auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true))) xaxisopts=(
         					shortlabel="period" label="period" type=linear display=all offsetmin=0.02 offsetmax=
         					0.02 griddisplay=auto_on reverse=true linearopts=(tickdisplaylist=tickdisplist
         					tickvaluelist=tickvallist viewmin=0 viewmax=maxfreq)) x2axisopts=(shortlabel=
         					"frequency" label="frequency" type=linear display=all offsetmin=0.02 offsetmax=0.02
         					griddisplay=auto_off reverse=true linearopts=(tickvaluelist=freqvallist
         					tickdisplaylist=freqdisplist viewmin=0 viewmax=maxfreq));
         		seriesplot x=eval (
            			ifn(2*constant('pi')/period(series),2*constant('pi')/period(series),0,0)) y=eval
            			(periodogram (series, meanadj=meanadj)) / xaxis=x2 legendlabel="periodogram" name
            			="period" tiplabel=(x="freq" y="i(f)");
         				if (exists(seasfreq) & seasfreq >= 0)
            				referenceline x=seasfreq / xaxis=x lineattrs=(pattern=dash color=
               				graphreference:color) curvelabelattrs=(color=graphreference:color) legendlabel
               				="seasonality" name="season";
         				endif;
         				if (exists(seasfreq) & seasfreq < maxfreq)
            				discretelegend "period" "season";
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
