proc template;
	path sashelp.tmplmst;
	source Risk.Risk.Graphics.Algap;
	define statgraph Risk.Risk.Graphics.Algap;
   		notes " AL gap";
		dynamic title _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / xaxisopts=(discreteopts=(tickvaluefitpolicy=stagger));
				barchartparm x=date y=buckvalue / display=(fill);
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
