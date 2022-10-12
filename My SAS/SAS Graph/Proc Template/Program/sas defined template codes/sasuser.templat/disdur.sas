
proc template;
	path sasuser.templat;
	source Disdur;
	define statgraph Disdur;
	   dynamic _byval2_;
	   begingraph / border=false;
			entrytitle halign=left textattrs=(size=11pt) "Treatment: " _BYVAL2_;
			layout overlay / xaxisopts=(label='Study Day' linearopts=(minorticks=true)) yaxisopts=(
						   	 label='Patient ID' display=(label)) walldisplay=none;
				innermargin / align=left separator=true separatorattrs=(color=black thickness=2px);
	            	axistable y=SID value=SUBJID / valueattrs=(size=9pt weight=bold) display=(values);
				endinnermargin;
					highlowplot y=SID low=STRT high=TRTDUR / lowcap=none highcap=none type=bar fillattrs
	            			    =(color=ghostwhite) outlineattrs=(color=black) name='Trt Dur';
				vectorplot x=NEXTDY y=SID xorigin=ADY yorigin=SID / arrowheads=false lineattrs=(
	            		   thickness=7px pattern=solid) group=AVALC name='resp';
				scatterplot x=BASEDY y=SID / markerattrs=(symbol=star color=red) name='Baseline'
	            	legendlabel='Baseline';
	         	discretelegend 'resp' / location=outside halign=left valign=bottom exclude=(' ')
	            	border=false;
	         	discretelegend 'Trt Dur' 'Baseline' / location=outside halign=right valign=bottom
	            	border=false;
      		endlayout;
		endgraph;
	end;
run;
