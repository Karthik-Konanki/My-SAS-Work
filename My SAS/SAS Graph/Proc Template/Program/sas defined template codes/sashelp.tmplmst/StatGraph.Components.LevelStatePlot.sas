proc template;
	path sashelp.tmplmst;
	source StatGraph.Components.LevelStatePlot;
	define statgraph statgraph.components.levelstateplot;
		dynamic title time integertime id idlabel idformat idtype interval _byline_ _bytitle_
      			_byfootnote_;
		begingraph;
			entrytitle title;
			layout overlay / yaxisopts=(display=all griddisplay=auto_on) xaxisopts=(display=all
					         griddisplay=auto_on type=idtype timeopts=(tickvalueformat=idformat) linearopts=(
					         integer=integertime));
				seriesplot x=time y=level / lineattrs=graphprediction (pattern=solid thickness=1);
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
