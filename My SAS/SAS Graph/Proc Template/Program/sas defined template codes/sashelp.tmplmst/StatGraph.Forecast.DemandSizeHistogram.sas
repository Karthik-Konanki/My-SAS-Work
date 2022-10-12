proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.DemandSizeHistogram;
	define statgraph StatGraph.Forecast.DemandSizeHistogram;
		dynamic title variable variablelabel _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(label="demand size" linearopts=(tickvalueformat=best12.))
         					 yaxisopts=(label="percent");
				histogram actualsize;
				densityplot actualsize / legendlabel="normal" name="normal";
				densityplot actualsize / kernel () legendlabel="kernel" name="kernel" lineattrs=
            				graphfit2;
				discretelegend "normal" "kernel" / across=1 location=inside autoalign=(topright
								topleft top);
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
