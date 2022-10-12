proc template;
	path sasuser.templat;
	source Unionall;
	define statgraph Unionall;
		begingraph / designwidth=350px designheight=400px;
			entrytitle "Yearly Profit for Sports Products";
			layout datalattice rowvar=PRODUCT_GROUP / rowdatarange=union rowgutter=5px rowheaders=
					left headerlabeldisplay=value headerlabelattrs=(weight=bold) headeropaque=true
					headerbackgroundcolor=GraphAltBlock:color columnaxisopts=(display=(tickvalues))
					rowaxisopts=(display=none displaysecondary=(tickvalues) linearopts=(tickvalueformat=
					dollar12.) griddisplay=on offsetmin=0);
			layout prototype;
            	barchart category=YEAR response=PROFIT / stat=sum;
			endlayout;
			endlayout;
		endgraph;
	end;
run;
