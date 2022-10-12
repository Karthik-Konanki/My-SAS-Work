proc template;
	path sasuser.templat;
	source Dosepanel;
	define statgraph Dosepanel;
		begingraph / designwidth=490px designheight=350px;
			layout datapanel classvars=(DOSE) / rows=1;
			layout prototype;
				bandplot x=DAYS limitupper=UCLM limitlower=LCLM / name="clm" display=(fill)
               			 fillattrs=GRAPHCONFIDENCE legendlabel="95% Confidence Limits";
				bandplot x=DAYS limitupper=UCL limitlower=LCL / name="cli" display=(outline)
               			 outlineattrs=GRAPHPREDICTIONLIMITS legendlabel="95% Prediction Limits";
				seriesplot x=DAYS y=PREDICTED / name="reg" lineattrs=GRAPHFIT legendlabel="Fit";
				scatterplot x=DAYS y=RESPONSE / primary=true markerattrs=(size=5px)
               				datatransparency=.5;
         	endlayout;
				sidebar / align=top;
		            entry "Predicted Response to Dosage (mg) over Time" / textattrs=GRAPHTITLETEXT
		               pad=(bottom=10px);
				endsidebar;
				sidebar / align=bottom;
	            	discretelegend "reg" "clm" "cli" / across=3;
				endsidebar;
      		endlayout;
		endgraph;
	end;
run;
