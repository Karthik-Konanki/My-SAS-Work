proc template;
	path sasuser.templat;
	source Onerow;
	define statgraph Onerow;
		begingraph / designwidth=360px designheight=180px;
			entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(PRODUCT_GROUP) / rows=1 headerlabeldisplay=value
				cellwidthmin=70 cellheightmin=70;
			layout prototype;
				barchart category=YEAR response=PROFIT / stat=sum;
			endlayout;
			endlayout;
   		endgraph;
	end;
run;
