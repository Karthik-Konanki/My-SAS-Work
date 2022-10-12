proc template;
	path sasuser.templat;
	source customSapphire;
	define style customSapphire;
	parent = styles.sapphire;
	class Header /
    	backgroundcolor = CXdae4f3;
   	class Footer /
    	backgroundcolor = CXdae4f3;
   	class RowHeader /
    	backgroundcolor = CXdae4f3;
   	class RowFooter /
    	backgroundcolor = CXdae4f3;
   	class graph /
    	attrpriority = "none";
   	class GraphColors /
	    'gaxis' = cx000000
	    'ggrid' = CX797c7e
	    'goutlines' = cx000000
	    'gborderlines' = cx000000
	    'greferencelines' = cx808080
	    'gtextt' = black
	    'gtext' = black;
   	style body from document /
    	marginbottom = .75in
    	margintop = .75in
    	marginright = .5in
    	marginleft = .75in;
   	class fonts /
    	'docFont' = ("<MTsans-serif>, Albany",8pt)
    	'headingFont' = ("<MTsans-serif>, Albany",9pt,bold)
    	'headingEmphasisFont' = ("<MTsans-serif>, Albany",10pt,bold italic)
    	'FixedFont' = ("<MTmonospace>, Courier",8pt)
    	'BatchFixedFont' = ("SAS Monospace, <MTmonospace>, Courier",7pt)
    	'FixedHeadingFont' = ("<MTmonospace>, Courier",8pt,bold)
    	'FixedStrongFont' = ("<MTmonospace>, Courier",8pt,bold)
    	'FixedEmphasisFont' = ("<MTmonospace>, Courier",8pt)
    	'EmphasisFont' = ("<MTsans-serif>, Albany",8pt,italic)
    	'StrongFont' = ("<MTsans-serif>, Albany",8pt,bold)
    	'TitleFont' = ("<MTsans-serif>, Albany",10pt,bold)
    	'TitleFont2' = ("<MTsans-serif>, Albany",9pt,bold);
   	style table from table /
    	bordercollapse = collapse
    	bordercolor = cx919191
    	frame = box
    	borderspacing = .05pt
    	cellpadding = 2pt
    	borderwidth = 3px;
   	class GraphFonts /
    	'GraphDataFont' = ("<MTsans-serif>, Albany",7pt)
    	'GraphUnicodeFont' = ("<MTsans-serif-unicode>",9pt)
    	'GraphValueFont' = ("<MTsans-serif>, Albany",9pt,bold)
    	'GraphLabelFont' = ("<MTsans-serif>, Albany",10pt,bold)
    	'GraphLabel2Font' = ("<MTsans-serif>, Albany",10pt,bold)
    	'GraphFootnoteFont' = ("<MTsans-serif>, Albany",10pt)
    	'GraphTitleFont' = ("<MTsans-serif>, Albany",11pt,bold)
    	'GraphTitle1Font' = ("<MTsans-serif>, Albany",14pt,bold)
    	'GraphAnnoFont' = ("<MTsans-serif>, Albany",10pt)
    	'NodeTitleFont' = ("<MTsans-serif>, Albany",9pt)
    	'NodeLabelFont' = ("<MTsans-serif>, Albany",9pt)
    	'NodeInputLabelFont' = ("<MTsans-serif>, Albany",9pt)
    	'NodeDetailFont' = ("<MTsans-serif>, Albany",7pt);
   	class GraphBorderLines /
    	color = CX000000
    	linethickness = 2px;
   	class GraphAxisLines /
    	color = CX000000
    	linethickness = 2px;
   	class GraphOutLines /
    	color = cx000000
    	linethickness = 2px;
   	class GraphAnnoLines /
    	color = cx000000
    	linethickness = 2px;
   	class GraphReference /
    	color = cx808080
    	linethickness = 2px;
   	class GraphWalls /
    	linethickness = 2px;
   	class GraphDataDefault /
    	linethickness = 2px;
   	class GraphBoxWhisker /
    	linethickness = 2px;
   	class GraphBoxMedian /
    	linethickness = 2px;
   	class GraphOther /
    	linethickness = 2px;
   	class GraphConfidence /
    	linethickness = 2px;
   	class GraphAnnoShape /
    	linethickness = 2px;
   	class GraphDataNodeDefault /
    	linestyle = 1
    	linethickness = 2px;
   	class GraphOutliers /
    	linestyle = 1
    	linethickness = 2px;
   	class GraphGridLines /
    	color = cx000000
    	linestyle = 1
    	linethickness = 2px;
	end;
run;
