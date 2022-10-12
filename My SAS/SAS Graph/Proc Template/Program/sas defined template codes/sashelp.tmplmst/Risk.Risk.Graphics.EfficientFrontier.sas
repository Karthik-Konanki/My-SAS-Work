proc template;
	path sashelp.tmplmst;
	source Risk.Risk.Graphics.EfficientFrontier;
	define statgraph Risk.Risk.Graphics.EfficientFrontier;
   		notes "Efficient Frontier Plot";
		dynamic title _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay;
				seriesplot x=risk y=return;
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
