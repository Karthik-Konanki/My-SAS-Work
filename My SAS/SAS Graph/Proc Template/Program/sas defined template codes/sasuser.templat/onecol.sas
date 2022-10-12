proc template;
	path sasuser.templat;
	source Onecol;
	define statgraph Onecol;
   		begingraph / designwidth=280px designheight=380px;
      		entrytitle "Yearly Profit for Sports Products";
      			layout datapanel classvars=(PRODUCT_GROUP) / columns=1 headerlabeldisplay=value
         			cellwidthmin=85 cellheightmin=85;
         		layout prototype;
            		barchart category=YEAR response=PROFIT / stat=sum orient=horizontal;
         		endlayout;
      			endlayout;
   		endgraph;
	end;
run;
