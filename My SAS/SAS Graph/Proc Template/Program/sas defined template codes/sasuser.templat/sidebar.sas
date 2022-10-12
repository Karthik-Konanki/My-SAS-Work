proc template;
	path sasuser.templat;
	source Sidebar;
	define statgraph Sidebar;
		begingraph / designwidth=490px designheight=800px border=false;
			layout datapanel classvars=(PRODUCT DIVISION) / columns=2 columngutter=10 rowgutter=5
         					headerlabelattrs=GRAPHLABELTEXT (weight=bold) rowaxisopts=(display=(tickvalues))
         					columnaxisopts=(display=(ticks tickvalues) offsetmin=0 linearopts=(tickvalueformat=
         					dollar6. viewmax=2000 tickvaluelist=(500 1000 1500 2000)));
			sidebar / align=top;
	            entry "Office Furniture Sales" / textattrs=GRAPHTITLETEXT (size=14pt) pad=(bottom
	               =5px);
			endsidebar;
			sidebar / align=bottom;
            	discretelegend "actual" "predict";
			endsidebar;
			layout prototype;
	            barchart category=MONTH response=ACTUAL / orient=horizontal fillattrs=GRAPHDATA1
	               barwidth=.6 name="actual";
	            barchart category=MONTH response=PREDICT / orient=horizontal fillattrs=GRAPHDATA2
	               barwidth=.3 name="predict";
			endlayout;
      		endlayout;
   		endgraph;
	end;
run;
