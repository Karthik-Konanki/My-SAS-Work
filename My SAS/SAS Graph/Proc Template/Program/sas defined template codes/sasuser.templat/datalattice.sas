 proc template;
	path sasuser.templat;
	source Datalattice;
	define statgraph Datalattice;
   		begingraph / designwidth=490px designheight=400px;
      		entrytitle "Heart Rates for Subjects";
      			layout datalattice rowvar=SUBJECT columnvar=TREATMENT / rows=3 rowgutter=5px
         			   cellheightmin=50 cellwidthmin=50 rowheaders=left skipemptycells=true columnaxisopts=
         			   (display=(tickvalues)) rowaxisopts=(display=none displaysecondary=(label) offsetmin=
         			   0);
         		layout prototype;
            		barchart category=TASK response=HEARTRATE / barlabel=true;
         		endlayout;
      			endlayout;
   		endgraph;
	end;
run;
