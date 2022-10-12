proc template;
	path sasuser.templat;
	source Panelgen;
	define statgraph Panelgen;
		nmvar PANELNUM TOTPANELS ROWS COLS YEAR;
		begingraph;
			entrytitle halign=right "Panel " PANELNUM " of " TOTPANELS / textattrs=GRAPHFOOTNOTETEXT;
      		layout datapanel classvars=(PRODUCT DIVISION) / rows=ROWS columns=COLS cellheightmin=50
         					 cellwidthmin=50 skipemptycells=true columnaxisopts=(type=time timeopts=(
         					 tickvalueformat=month.)) rowaxisopts=(griddisplay=on) panelnumber=PANELNUM;
         	layout prototype;
            	seriesplot x=MONTH y=ACTUAL / lineattrs=GRAPHDATA1;
         	endlayout;
         	sidebar / align=top;
            	entry "Office Furniture Sales for " YEAR / textattrs=GRAPHTITLETEXT;
         	endsidebar;
      		endlayout;
		endgraph;
	end;
run;
