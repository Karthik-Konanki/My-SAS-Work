proc template;
	path sashelp.tmplmst;
	source StatGraph.Histogram;
	define statgraph StatGraph.Histogram;
   		dynamic scale _byline_ _bytitle_ _byfootnote_;
   		begingraph;
      		layout overlay;
        		histogram histvar / fillattrs=(color=graphdatadefault:color);
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
