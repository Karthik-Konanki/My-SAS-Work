proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.ModelPlot;
	define statgraph StatGraph.Forecast.ModelPlot;
   		dynamic title time variable variablelabel id idlabel idformat idtype interval integertime
      			confidencelabel _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / yaxisopts=(shortlabel=variable label=variablelabel display=all
         					 griddisplay=auto_on) xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					 tickvalueformat=idformat) display=all griddisplay=auto_on linearopts=(integer=
         					 integertime));
         		bandplot limitupper=upper limitlower=lower x=time / display=(fill) fillattrs=
            			 graphconfidence datatransparency=0.5 name="conf" legendlabel=confidencelabel;
         		scatterplot x=time y=actual / markerattrs=graphdatadefault name="actual" legendlabel
            				="actual" tip=(time actual predict lower upper);
         		seriesplot x=time y=predict / lineattrs=graphprediction (pattern=solid thickness=1)
            				name="predicted" legendlabel="predicted" tip=(time actual predict lower upper);
         		discretelegend "actual" "predicted" "conf" /;
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
