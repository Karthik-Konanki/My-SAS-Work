proc template;
	path sashelp.tmplmst;
	source Risk.Risk.Graphics.EfficientFrontierSurface;
	define statgraph Risk.Risk.Graphics.EfficientFrontierSurface;
		notes "Efficient Frontier Surface Plot";
		dynamic title _byline_ _bytitle_ _byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay3d;
				surfaceplotparm x=risk y=date z=return;
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
