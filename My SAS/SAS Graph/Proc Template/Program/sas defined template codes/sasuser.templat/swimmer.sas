proc template;
	path sasuser.templat;
	source Swimmer;
	define statgraph Swimmer;
		dynamic _byval2_;
			begingraph;
				entrytitle halign=left textattrs=(size=11pt) "Treatment: " _BYVAL2_;
				entryfootnote halign=left textattrs=(Family="Arial" color=black size=11pt)
         			"Each bar represents one subject in the study.  Right arrow cap indicates continued response.";
      			entryfootnote halign=left textattrs=(Family="Arial" color=black size=11pt)
         			'A durable responder is a subject who has confirmed response for at least 183 days (6 months).';
      			layout overlay / xaxisopts=(label='Months') yaxisopts=(label=
         						'Subjects Received Study Drug' display=none);
					highlowplot y=ITEM low=LOW high=HIGH / highcap=HIGHCAP type=bar group=STAGE
								lineattrs=(color=black) name='stage' barwidth=1 fillattrs=(transparency=0.6);
					highlowplot y=ITEM low=STARTLINE high=ENDLINE / group=STATUS lineattrs=(thickness=2
								pattern=solid) name='status';
					scatterplot y=ITEM x=START / markerattrs=(symbol=trianglefilled size=8 color=
								darkgray) name='s' legendlabel='Response start';
					scatterplot y=ITEM x=END / markerattrs=(symbol=circlefilled size=8 color=darkgray)
								name='e' legendlabel='Response end';
					scatterplot y=ITEM x=DURABLE / markerattrs=(symbol=squarefilled size=6 color=black)
								name='d' legendlabel='Durable responder';
					scatterplot y=ITEM x=START / markerattrs=(symbol=trianglefilled size=8) group=STATUS;
					scatterplot y=ITEM x=END / markerattrs=(symbol=circlefilled size=8) group=STATUS;
					discretelegend 'stage' / title='Disease Stage';
					discretelegend 'status' 's' 'e' 'd' / location=inside across=1 halign=right valign=
						bottom border=false;
      			endlayout;
		endgraph;
	end;
run;
