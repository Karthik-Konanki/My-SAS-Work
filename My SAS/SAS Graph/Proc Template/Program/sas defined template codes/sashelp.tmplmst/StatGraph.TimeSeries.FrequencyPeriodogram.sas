proc template;
	path sashelp.tmplmst;
	source StatGraph.TimeSeries.FrequencyPeriodogram;
	define statgraph StatGraph.TimeSeries.FrequencyPeriodogram;
   		dynamic title variable variablelabel fid fidlabel idformat idtype interval integertime x
      			series meanadj _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel="power" label="power" display=all griddisplay=
         						 auto_on offsetmin=0.05 linearopts=(tickvalueformat=(extractscale=true))) xaxisopts=(
         						 shortlabel=fid label=fidlabel type=idtype timeopts=(tickvalueformat=idformat)
         					 	 display=all offsetmin=0.05 griddisplay=auto_on linearopts=(tickvaluelist=(0 0.79
         						 1.57 2.36 3.14) tickdisplaylist=("0" "(*esc*){unicode pi}/4" "(*esc*){unicode pi}/2"
         						 "3(*esc*){unicode pi}/4" "(*esc*){unicode pi}")));
         		seriesplot x=eval (ifn(2*constant('pi')/period(x),2*constant('pi')/period(x),0,0)) y
            				=eval (periodogram (series, meanadj=meanadj)) / legendlabel="periodogram" name=
            				"period" tiplabel=(x="freq");
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
