proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.DemandErrorsPlot;
	define statgraph StatGraph.Forecast.DemandErrorsPlot;
		dynamic title variable variablelabel _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(display=all griddisplay=auto_on linearopts=(integer=true))
							yaxisopts=(display=all griddisplay=auto_on label="prediction errors");
				bandplot limitupper=eval (2*std) limitlower=eval (-2*std) x=index / display=(fill)
            			fillattrs=graphconfidence datatransparency=0.5 name="error2" legendlabel=
            			"two standard errors";
         		bandplot limitupper=eval (std) limitlower=eval (-1*std) x=index / display=(fill)
            			fillattrs=graphconfidence name="error1" legendlabel="one standard error";
         		needleplot x=index y=error / lineattrs=graphdatadefault display=all markerattrs=
            				graphdatadefault name="prediction" legendlabel="prediction errors" tip=(index
            				error std);
         		discretelegend "prediction" "error1" "error2" /;
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
