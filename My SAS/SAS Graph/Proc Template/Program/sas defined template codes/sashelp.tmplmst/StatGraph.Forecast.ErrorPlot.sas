proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.ErrorPlot;
	define statgraph StatGraph.Forecast.ErrorPlot;
   		dynamic title time variable variablelabel id idlabel idformat idtype interval integertime
      			_byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		entrytitle title;
      		layout overlay / xaxisopts=(shortlabel=id label=idlabel type=idtype timeopts=(
         					tickvalueformat=idformat) linearopts=(integer=integertime));
         		bandplot limitupper=eval (2*std) limitlower=eval (-2*std) x=time / display=(fill)
            			 extend=true fillattrs=graphconfidence datatransparency=0.5 name="error2"
            			 legendlabel="two standard errors";
         		bandplot limitupper=eval (std) limitlower=eval (-1*std) x=time / display=(fill)
            			 extend=true fillattrs=graphconfidence name="error1" legendlabel=
            			 "one standard error";
         		needleplot x=time y=error / lineattrs=graphdatadefault display=all name="prediction"
            			   legendlabel="prediction errors" tip=(time error std);
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
