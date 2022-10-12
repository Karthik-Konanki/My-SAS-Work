proc template;
	path sasuser.templat;
	source Defaultdatatips1;
	define statgraph Defaultdatatips1;
   		begingraph;
      		entrytitle "Scatter Plot with Default Data Tips";
      		layout overlay;
         		scatterplot x=HEIGHT y=WEIGHT / group=SEX name="s" rolename=(tip1=NAME tip2=AGE) tip
            				=(tip1 tip2 X Y GROUP) tiplabel=(tip1="Student Name") tipformat=(tip2=2.);
         		discretelegend "s";
      		endlayout;
   		endgraph;
	end;
run;
