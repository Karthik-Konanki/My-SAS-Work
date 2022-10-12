proc template;
	path sasuser.templat;
	source multipanel;
	define statgraph Multipanel;
		begingraph / designwidth=340px designheight=340px;
			layout datapanel classvars=(PRODUCT_CATEGORY) / rows=2 columns=2 skipemptycells=true
				headerlabeldisplay=value rowaxisopts=(griddisplay=on offsetmin=0 display=(tickvalues) 
				linearopts=(tickvalueformat=dollar12.));
			layout prototype;
				barchart x=YEAR y=PROFIT / fillattrs=GRAPHDATA1;
         	endlayout;
         	sidebar / align=top;
            	entry "Profit for Selected Sports Items" / textattrs=GRAPHTITLETEXT;
         	endsidebar;
      		endlayout;
   		endgraph;
	end;
run;
