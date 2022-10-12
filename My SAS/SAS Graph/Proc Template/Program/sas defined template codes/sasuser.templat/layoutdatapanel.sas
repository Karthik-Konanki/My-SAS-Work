proc template;
	path sasuser.templat;
	source Layoutdatapanel;
	define statgraph Layoutdatapanel;
		begingraph / drawspace=layoutpercent;
			layout datapanel classvars=(COUNTRY PRODTYPE PRODUCT) / columns=4 rowdatarange=unionall
         					 headerlabeldisplay=value headerpack=true headersplitcount=2 headerbackgroundcolor=
							 GraphAltBlock:color;
			layout prototype;
            	barchart x=YEAR y=TOTALACTUAL;
         	endlayout;
      		endlayout;
   		endgraph;
	end;
run;
