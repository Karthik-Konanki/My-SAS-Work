proc template;
	path sasuser.templat;
	source Sparse;
	define statgraph Sparse;
		begingraph / designwidth=490px designheight=450px;
			entrytitle "Heart Rates for Subjects";
			layout datapanel classvars=(SUBJECT TREATMENT) / columns=4 rows=3 cellheightmin=50
         					 cellwidthmin=50 skipemptycells=true sparse=true columnaxisopts=(display=(tickvalues)
         					 ) rowaxisopts=(display=(label) offsetmin=0);
			layout prototype;
            	barchart category=TASK response=HEARTRATE / barlabel=true;
         	endlayout;
      		endlayout;
   		endgraph;
	end;
run;
