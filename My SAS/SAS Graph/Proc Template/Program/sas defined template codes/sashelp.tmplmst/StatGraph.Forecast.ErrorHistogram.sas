proc template;
	path sashelp.tmplmst;
	source StatGraph.Forecast.ErrorHistogram;
	define statgraph StatGraph.Forecast.ErrorHistogram;
		dynamic title series variable variablelabel _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
 			layout overlay / xaxisopts=(label="prediction error" linearopts=(tickvalueformat=
         					 best12.)) yaxisopts=(label="percent");
         		histogram series;
         		densityplot series / legendlabel="normal" name="normal";
         		densityplot series / kernel () legendlabel="kernel" name="kernel" lineattrs=
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
