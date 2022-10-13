/****************************************************************************************
Program:          Swimmerplot.sas

SAS Version:      SAS (SAS 9.4m5)
Developer:        ----------------
Date:             2020-03-31
Purpose:          Clinical Graph. 
Operating Sys:    Windows 10

Macros:           NONE

Input:            swimmer.sas7bdat

Output:           SwimmerPlot1.rtf

----------------------------------------------------------------------------------------- 
****************************************************************************************/

options validvarname=upcase;

%let outpath = E:\NewDisk\SAS\My SAS\SAS Graph\Proc Template\Output;
%let outname = SwimmerPlot;
ods path(prepend) work.swimmer(update);

/*****************************************/
/***         DATA PROCESSING           ***/
/*****************************************/

data swimmer;
  input item stage $4-12 low high highcap $25-40 status $40-60 start end durable;
  startline=start; endline=end;
  if status ne ' ' then do;
    if end eq . then endline=high-0.3;
    if start eq . then startline=low+0.3;
  end;
  if stage eq ' ' then durable=.;
  ymin=-1;
  datalines;
1  Stage 1  0  18.5     FilledArrow     Complete response      6.5  13.5  -0.25
2  Stage 2  0  17.0                     Complete response     10.5  17.0  -0.25
3  Stage 3  0  14.0     FilledArrow     Partial response       2.5   3.5  -0.25
3           0  14.0     FilledArrow     Partial response       6.0     .  -0.25
4  Stage 4  0  13.5     FilledArrow     Partial response       7.0  11.0     .
4           0  13.5     FilledArrow     Partial response      11.5     .     .
5  Stage 1  0  12.5     FilledArrow     Complete response      3.5   4.5  -0.25
5           0  12.5     FilledArrow     Complete response      6.5   8.5  -0.25
5           0  12.5     FilledArrow     Partial response      10.5     .  -0.25
6  Stage 2  0  12.6     FilledArrow     Partial response       2.5   7.0     .
6           0  12.6     FilledArrow     Partial response       9.5     .     .
7  Stage 3  0  11.5                     Complete response      4.5  11.5  -0.25
8  Stage 1  0   9.5                     Complete response      1.0   9.5  -0.25
9  Stage 4  0   8.3                     Partial response       6.0     .     .
10 Stage 2  0   4.2     FilledArrow     Complete response      1.2     .     .
;
run;


data attrmap;
length ID $ 9 linecolor markercolor $ 20;
input id $ value $10-30 linecolor $ markercolor;
datalines;
status   Complete response    darkred   darkred
status   Partial response     blue      blue
;
run;

proc template;
	define statgraph swimmer;
		begingraph;
			dynamic _byval2_;
				entrytitle halign = left textattrs = (size = 11pt) "Treatment: " _byval2_;
				entryfootnote halign=left textattrs=(Family="Arial" color=black
							size=11pt) "Each bar represents one subject in the study.  Right arrow cap indicates continued response." ;
				entryfootnote halign=left textattrs=(Family="Arial" color=black
							size=11pt) 'A durable responder is a subject who has confirmed response for at least 183 days (6 months).' ;
					discreteattrmap name="status" / ignorecase=true;
 						value "Complete response" / lineattrs=(color=darkred) markerattrs=(color=darkred);
 						value "Partial response" / lineattrs=(color=blue) markerattrs=(color=blue);
 					enddiscreteattrmap;
					discreteattrvar attrvar=status var=status attrmap="status";
					layout overlay / xaxisopts = (label = 'Months')
									 yaxisopts = (label = 'Subjects Received Study Drug' reverse=true);
					  highlowplot y=item low=low high=high / highcap=highcap type=bar group=stage 
          						lineattrs=(color=black) name='stage' barwidth=1 fillattrs=(transparency=0.6) includemissinggroup=false;
					  highlowplot y=item low=startline high=endline / group=status lineattrs=(thickness=2 pattern=solid) 
          						name='status'  includemissinggroup=false;
					  scatterplot y=item x=start / markerattrs=(symbol=trianglefilled size=8 color=darkgray) name='s' legendlabel='Response start';
  					  scatterplot y=item x=end / markerattrs=(symbol=circlefilled size=8 color=darkgray) name='e' legendlabel='Response end';
  					  scatterplot y=item x=durable / markerattrs=(symbol=squarefilled size=6 color=black) name='d' legendlabel='Durable responder';
  					  scatterplot y=item x=start / markerattrs=(symbol=trianglefilled size=8) group=status;
  					  scatterplot y=item x=end / markerattrs=(symbol=circlefilled size=8) group=status;
					  discretelegend 'stage'/ title='Disease Stage';
            		  discretelegend 'status' 's' 'e' 'd'/ location=inside across=1 halign = right valign = bottom border = false;
         			endlayout;
      	endgraph;
   end;
run;

options nobyline nodate nonumber orientation=landscape;
ods graphics on / imagefmt = png width = 8in noborder;
ods rtf file = "&outpath.\&outname..rtf"
        image_dpi = 300 ;

proc sgrender data = swimmer template = swimmer dattrmap = attrmap;
run;

ods rtf close;
ods graphics off;
