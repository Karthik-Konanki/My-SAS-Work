proc template;
	path sasuser.templat;
	source Defaultdatatips;
	define statgraph Defaultdatatips;
		begingraph;
			entrytitle "Scatter Plot with Default Data Tips";
			layout overlay;
				scatterplot x=HEIGHT y=WEIGHT / group=SEX name="s";
				discretelegend "s";
			endlayout;
   		endgraph;
	end;
run
