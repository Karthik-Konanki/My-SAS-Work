****************************************************************************
****************************************************************************
**-Input:
**    Dataset &INDSN with variable &DATEVAR and/or &TIMEVAR, OR &DTVAR
**
**-Output:
**    Dataset &OUTDSN with variable &ISOVAR added at the end of the list of variables of &INDSN dataset.
**
**-Usage Examples:
**    %m_isodtc_v1(indsn=testc, outdsn=testc1, isovar=isodtc, datevar=%str(datevaryear datevarmon datevarday));
**    %m_isodtc_v1(indsn=testc, isovar=isodtc, datevar=%str(datevar));
**    %m_isodtc_v1(indsn=testc, datevar=%str(datevaryear datevarmon datevarday), timevar=%str(timevarhour timevarmin timevarsec));
**    %m_isodtc_v1(indsn=testc, datevar=%str(datevaryear datevarmon datevarday), timevar=%str(timevar));
**    %m_isodtc_v1(indsn=testc, datevar=%str(datevar), timevar=%str(timevarhour timevarmin timevarsec));
**    %m_isodtc_v1(indsn=testc, outdsn=testc_out, datevar=%str(datevar), timevar=%str(timevar));
**    %m_isodtc_v1(indsn=testc, isovar=isodtc, dtvar=%str(dtvar));
**
**    Examples of formats for output &ISOVAR:
**			YYYY-MM-DD
**			YYYY---DD
**          ----DD
**          -----THH:MM
**          YYYY-MM--THH:MM:SS
**          YYYY-MM-DDTHH:MM
**
**-Parameter settings and descriptions (important information):
**    INDSN     – Name of the input dataset. The parameter is required.
**    OUTDSN    – Name of the output dataset. If missing, set it equal to &INDSN.
**    ISOVAR    – Name of variable(s) for output datetime in ISO 8601 format. 
**                If missing, set to ISOVAR.
**    DATEVAR   – Name of the date variable (could be a single DATE, or three 
**                as %str(YEAR MONTH DAY), each can be numeric or character). 
**                1 Required if DTVAR is not specified. Only one of DATEVAR or 
**                  DTVAR can be specified.
**                2 If DATEVAR is entered as a single variable and in string 
**                  format, it needs to be in DATE9 or YYMMDD10 format.
**                3 If DATEVAR is entered as 3 separate variables, they need 
**                  to be space separated and in YEAR, MONTH, DAY order.
**                4 If DATEVAR is entered as 3 separate variables and any part 
**                  is invalid, then it is assumed to be missing, and a message 
**                  is output.
**                5 UNK is a valid value for each of Year, Month, Day. NA is 
**                  also valid value for a month.
**    TIMEVAR   – Name of the time variable (could be a single TIME, or three as 
**                %str(HOUR MINUTE SECOND), or two as %str(HOUR MINUTE), each 
**                can be numeric or character).
**                1 Optional, but only one of TIMEVAR of DTVAR can be specified. 
**                2 If TIMEVAR is specified, then DATEVAR has to be specified.	
**                3 If TIMEVAR is entered as a single variable and in string format, 
**                  it needs to be in HH:MM or HH:MM:SS format.
**                4 If TIMEVAR is entered as 3 separate variables, they need to be 
**                  space separated and in HOUR, MIN, SEC order.
**                5 If TIMEVAR is entered as 2 separate variables, they need to be 
**                  space separated and in HOUR, MIN order.
**                6 If TIMEVAR is entered as 2 or 3 separate variables and any part 
**                  of TIMEVAR is invalid then it is assumed to be missing, and a 
**                  message is output.
**    DTVAR     - Name of datetime variable (could be either numeric or character).
**				  Optional, but if DTVAR is specified, then DATEVAR and TIMEVAR 
**                cannot be specified.
**
****************************************************************************
****************************************************************************
** Modification History
**
** Date of Modification:
** Details:
**
**
****************************************************************************
****************************************************************************;

%macro m_isodtc_v1(
	      indsn     = , /* NAME OF INPUT DATASET                                                   */
	      outdsn    = , /* NAME OF OUTPUT DATASET                                                  */
          isovar    = , /* NAME OF OUTPUT DATETIME VAR IN ISO8601 FORMAT                           */
          datevar   = , /* NAME OF DATE VARIABLE, CAN BE MULTIPLE                                  */
          timevar   = , /* NAME OF TIME VARIABLE, CAN BE MULTIPLE                                  */
          dtvar     =   /* NAME OF DATETIME VARIABLE, USE IF DATEVAR AND TIMEVAR ARE NOT AVAILABLE */
          );
    
/** FORMAT FOR MONTH TRANSLATION TO ISO FORMAT **/    
proc format;
  value $mon 'JAN' = '01'
  			 'FEB' = '02'
			 'MAR' = '03'
			 'APR' = '04'
			 'MAY' = '05'
			 'JUN' = '06'
			 'JUL' = '07'
			 'AUG' = '08'
			 'SEP' = '09'
			 'OCT' = '10'
			 'NOV' = '11'
			 'DEC' = '12'
			 'NA'  = '-'
			 'UNK' = '-'
			 ' '   = '-'
  ;
run;


/*****************************************/
/**   MESSAGE TEMPLATES                 **/
/*****************************************/    
%local datevar_n timevar_n indsn1;
%let errvar_ = 0;

%macro logmsg(ng=1,type=N);
   %if &type = E %then %let msgprefix = %str(ERR)OR:;
   %if &type = W %then %let msgprefix = %str(WAR)NING:;
   %if &type = N %then %let msgprefix = %str(NOT)ICE:;
 
   %if &ng = 1 %then %put -------------------------------------------------------------------------------------------;
   %put &msgprefix %upcase(&_logmsg.);
   %if &ng = 1 %then %put -------------------------------------------------------------------------------------------;
%mend;


/*****************************************/
/**   PARAMETER CHECKS                  **/
/*****************************************/

/** CHECK THAT PARAMETER INDSN IS NOT BLANK    **/
%if %length(&INDSN) = 0 %then %do;
	%let _logmsg = Parameter INDSN is required.;
	%logmsg(type=E, ng=1);
	%return;
%end;

/** CHECK THAT DATASET INDSN EXISTS              **/
/** IF IT IS SPECIFIED WITH A PERMANENT LIBRARY  **/
/** NAME, THEN READ IT INTO WORK LIBRARY         **/
%if %sysfunc(exist(&INDSN)) = 0 %then %do;
	%let _logmsg = Dataset &INDSN does not exist.  The macro will stop executing.;
	%logmsg(type=E, ng=1);
	%return;
%end;
%else %do;
    %if %index(&INDSN, .) ne 0 %then %do;
		%let workds=0;		
		%let INDSN1=__%scan(&INDSN, 2, '.')__;
		data &indsn1;
			set &indsn;
		run;
		%let INDSN=&INDSN1;
	%end;
	%else %do;
		%let workds = 1;
	%end;
%end;

/** IF PARAMETER OUTDSN MISSING, SET IT EQUAL TO INDSN **/
%if %length(&OUTDSN) = 0 %then %do;
	%let _logmsg = OUTDSN parameter value is missing, it will be assigned to the same value as INDSN.;
	%logmsg(type=N, ng=1);
	%let OUTDSN = &INDSN;
%end;

/** CHECK THAT PARAMETER ISOVAR IS NOT BLANK, OTHERWISE SET IT TO 'ISOVAR' **/   
%if %length(&ISOVAR) = 0 %then %do;
	%let _logmsg = ISOVAR parameter value is missing, new ISO variable named ISOVAR will be created.;
	%logmsg(type=N, ng=1);
	%let ISOVAR = ISOVAR;
%end;

%if %length (&DATEVAR) = 0 and %length(&DTVAR) = 0 %then %do;
	/** CHECK THAT EITHER DATEVAR OR DTVAR IS SPECIFIED **/
	%let _logmsg = At least one of the parameters DATEVAR or DTVAR needs to be specified.;
	%logmsg(type=E, ng=1);
	%return;
%end;
%else 
%if %length (&DATEVAR) ne 0 and %length(&DTVAR) ne 0 %then %do;
	/** CHECK THAT ONLY ONE OF THE PARAMETERS DATEVAR OR DTVAR IS SPECIFIED **/  
	%let _logmsg = Only one of the parameters DATEVAR and DTVAR needs to be specified.;
	%logmsg(type=E, ng=1);
	%return;
%end;
%else 
%if %length (&TIMEVAR) ne 0 and %length(&DATEVAR) eq 0 %then %do;
	/** CHECK THAT IF TIME IS SPECIFIED THAN DATE IS ALSO SPECIFIED **/   
	%let _logmsg = TIMEVAR is specified but DATEVAR is not.;
	%logmsg(type=E, ng=1);
	%return;
%end;
%else 
%if %length (&TIMEVAR) ne 0 and %length(&DTVAR) ne 0 %then %do;
	/** CHECK THAT ONLY ONE OF THE PARAMETERS TIMEVAR OR DTVAR IS SPECIFIED **/   
	%let _logmsg = Only one of the parameters TIMEVAR and DTVAR needs to be specified.;
	%logmsg(type=E, ng=1);
	%return;
%end;


%macro scanstr(dsn=,vars=);
	%let i = 1;
  	%let element = %scan(&vars.,&i.);
  	%do %until(&element eq %nrstr( ));    	
    	%if %m_varexist_v1(&dsn, &element)=0 %then %do;
	     	%let _logmsg = Variable &ELEMENT does not exist in dataset &DSN.. The macro will stop executing.;
         	%logmsg(type=E, ng=1);
	    	%let errvar_ = 1;
    		%return;
    	%end;
	    %let i = %eval(&i+1);
	    %let element = %scan(&vars.,&i.);
	%end;
%mend;

/** CHECK HOW MANY PARTS IN PARAMETER DATEVAR **/ 
%if %length (&DATEVAR) ne 0 %then %do;
	%let datevar_n=%sysfunc(countw(&datevar));
	%if &datevar_n ne 1 and &datevar_n ne 3 %then %do;
		%let _logmsg = DATEVAR needs to be specified as either one variable for total date, or separate YEAR, MONTH, DAY variables, in this order.;
		%logmsg(type=E, ng=1);
		%return;
	%end;
	%scanstr(dsn=&INDSN,vars=&DATEVAR);
%end;

/** CHECK HOW MANY PARTS IN PARAMETER TIMEVAR **/
%if %length (&TIMEVAR) ne 0 %then %do;
	%let timevar_n=%sysfunc(countw(&timevar));
	%if &timevar_n ne 1 and &timevar_n ne 2 and &timevar_n ne 3 %then %do;
		%let _logmsg = TIMEVAR needs to be specified as either one variable for total time, or separate HOURS, MINS, SECS variables, in this order, SECS is optional.;
		%logmsg(type=E, ng=1);
		%return;
	%end;
	%scanstr(dsn=&INDSN,vars=&TIMEVAR);
%end;

/** CHECK VARIABLE DTVAR EXISTS IN INDSN **/   
%if %length (&DTVAR) ne 0 %then %do;
	%if %m_varexist_v1(&indsn, &dtvar)=0 %then %do;
	    %let _logmsg = Variable &DTVAR dose not exist in &INDSN..;
	    %logmsg(type=E, ng=1);
		%return;
	%end;
%end;

%if &errvar_ = 0 %then %do; 
	/******************************************************/
	/**  READ VARIABLE TYPES FROM PROC CONTENTS          **/
	/******************************************************/ 

	/** TYPE = 1 IS NUMERIC AND TYPE = 2 IS CHARACTER **/
	proc contents data=&indsn out=cont_&indsn(keep=name type format) noprint;
	run;

	/** CREATE MACRO VARIABLES WITH TYPE FOR EACH VARIABLE **/
	data _null_;
		set cont_&indsn;
		if type = 1 then call symput(catx('_',name,'t'), 'N');
		else 
        if type = 2 then call symput(catx('_',name,'t'), 'C');
		call symput(catx('_',name,'f'), strip(upcase(format)));
	run;

	/********************************************************/
	/**  CREATE ISOVAR DEPENDING ON 1 OR 3 PARTS ENTERED   **/
	/********************************************************/
	data &outdsn;
		set &indsn;
		length  &isovar $19 datepart $20 timepart $8;

		datepart = '';
		timepart = '';
		/********************/
		/** DTVAR PART     **/
		/********************/
		%if %length (&DTVAR) ne 0  %then %do;
			length dtvarv_c $20 dtvarnm $30 dpart tpart $20;
			dtvarnm = "&dtvar";

			_dtvarv = .;

			check_format = symget(catx('_', dtvarnm, 'f'));
			check_type   = symget(catx('_', dtvarnm, 't'));

            dtvarv  = cats(vvaluex(dtvarnm));
			
			if check_type = 'N' then dtvarv_c = put(dtvarv, 29.);
				                else dtvarv_c = dtvarv;

            if check_type = 'N' then do;
    			if check_format =: 'DATETIME' then do;
    			   dtvarv_c = put(input(dtvarv,datetime.),e8601dt.);
    			   got_here = 1;
    			end;
    			else
    			if check_format =: 'E8601DT' then do;
    			   dtvarv_c = put(dtvarv, 29.);
    			   got_here = 2;
    			end;
    			else do;
                   if length(dtvarv_c) lt 10 then do;
    				  put "-------------------------------------------------------------------------------------------";
    				  put "WAR" "NING: INVALID DTVAR: " dtvarv_c= ". SET TO MISSING. ";
    				  put "-------------------------------------------------------------------------------------------";
    				  dtvarv_c = '';
                   end;
                   else 
                      dtvarv_c = put(input(dtvarv,best.),e8601dt.);
    			   got_here = 3;
    			end;
			end;

			dtvarx = check_type;
			*file log;
		    *put "Check --> " dtvarv= dtvarnm= dtvarv_c= dtvarx= check_format= got_here=;

            /* NEED TO MAKE SURE THAT DATE MATCHES FULL YYYY-MM-DD FORMAT AND TIME MATCHES EITHER HH:MM OR HH:MM:SS FORMAT */
			if index(dtvarv_c,"T") ne 0 then do;
               dpart = substr(dtvarv_c,1,index(dtvarv_c,"T") - 1);
		       tpart = substr(dtvarv_c,index(dtvarv_c,"T") + 1);
			end;
			else do;
			   dpart = dtvarv_c;
               tpart = "";
			end;
			check_match1 = prxmatch('/\d{4}-\d{2}-\d{2}/', dpart);
			check_match2 = prxmatch('/\d{2}:\d{2}:\d{2}/',tpart);
			check_match3 = prxmatch('/\d{2}:\d{2}/',tpart);

			/** CHECK THAT THE DATE IS IN DATETIME FORMAT **/       
			if tpart ne "" and dpart ne "" and 
               check_match1 = 1 and 
              (check_match2 = 1 or check_match3 = 1) then do; 
			     &isovar = dtvarv_c;
			end;
			else
			if tpart = "" and dpart ne "" and check_match1 = 1 then do;
			   &isovar = dtvarv_c;
			end;
            *put "Check --> DTVAR " &isovar= dtvarv_c= dpart= tpart= check_match1= check_match2= check_match3=;
			drop dtvarv_c dtvarnm dtvarv check_match: dpart tpart
                 _dtvarv check_format check_type got_here dtvarx;
		%end; 

		%else %do;
			/********************/
			/* DATE PART       **/
			/********************/
			%if &datevar_n = 3 %then %do;
				length datevaryearv_c $4 datevarmonv_c $3 datevardayv_c $3 datevaryearnm datevarmonnm datevardaynm $30;

				/** VARIABLE NAMES AS STRINGS  **/ 
				datevaryearnm = scan("&datevar", 1, ' ');
				datevarmonnm  = scan("&datevar", 2, ' ');
				datevardaynm  = scan("&datevar", 3, ' ');

				/** CREATE VARIABLE FROM THE STRING WITH THE NAME OF THE VARIABLE FOR EACH DATE PART ***/ 
				datevaryearv = cats(vvaluex(datevaryearnm));
				datevarmonv  = cats(vvaluex(datevarmonnm));
				datevardayv  = cats(vvaluex(datevardaynm));

				/** IF NUMERIC VARIABLES THEN CONVERT T0 CHAR FIRST **/
				if symget(catx('_', datevaryearnm, 't')) = 'N' then datevaryearv_c = put(datevaryearv, 4.);
					                                           else datevaryearv_c = datevaryearv;
				if symget(catx('_', datevarmonnm, 't'))  = 'N' then datevarmonv_c  = put(datevarmonv, 3.);
                                          					   else datevarmonv_c  = datevarmonv;
				if symget(catx('_', datevardaynm, 't'))  = 'N' then datevardayv_c  = put(datevardayv, 3.);
					                                           else datevardayv_c  = datevardayv;

				/** ATTACH LEADING ZEROES  **/	
				if prxmatch('/\d{1}/', datevarmonv_c) and length(cats(datevarmonv_c)) = 1  then datevarmonv_c = '0'||datevarmonv_c;
				if prxmatch('/\d{1}/', datevardayv_c) and length(cats(datevardayv_c)) = 1  then datevardayv_c = '0'||datevardayv_c;

				/** IF INVALID FORMAT ENTERED  **/ 
				if prxmatch('/\d{4}|UNK| /', datevaryearv_c) ne 1 then do;
				   put "-------------------------------------------------------------------------------------------";
				   put "WAR" "NING: INVALID YEAR: " datevaryearv_c= ". SET TO MISSING. ";
				   put "-------------------------------------------------------------------------------------------";
				   datevaryearv_c = '';
				end;
			
				if prxmatch('/0[1-9]|1[012]|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|UNK|NA| /', datevarmonv_c) ne 1  then do;
				   put "-------------------------------------------------------------------------------------------";
                   put "WAR" "NING: INVALID MONTH: " datevarmonv_c= ". SET TO MISSING. ";;
				   put "-------------------------------------------------------------------------------------------";
				   datevarmonv_c = '';
				end;

				if prxmatch('/[0-2]\d|3[01]|UNK| /', datevardayv_c) ne 1 then do;
                   put "-------------------------------------------------------------------------------------------";
				   put "WAR" "NING: INVALID DAY: " datevardayv_c= ". SET TO MISSING. ";;
				   put "-------------------------------------------------------------------------------------------";
				   datevardayv_c = '';
				end;

				/** IF DAY AND YEAR MISSING OR UNK **/  
				if datevaryearv_c in ('UNK', '')       then datevaryearv_c = '-';
				if datevarmonv_c  in ('UNK', 'NA', '') then datevarmonv_c  = '-';
				if datevardayv_c  in ('UNK', '')       then datevardayv_c  = '-';

				/** IF MONTH ENTERED VERBATIM **/
				if prxmatch('/JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC/', datevarmonv_c) = 1 then 
					datevarmonv_c=put(datevarmonv_c, $mon.);
				
				datepart = catx('-',datevaryearv_c,datevarmonv_c,datevardayv_c);

				drop datevaryearv_c datevarmonv_c datevardayv_c  datevaryearnm datevarmonnm 
                     datevardaynm   datevaryearv  datevarmonv    datevardayv;

			%end;
			%else %if &datevar_n=1 %then %do;
				length datevarv_c $20 datevarnm $30;

				/** VARIABLE NAMES AS STRINGS **/  
				datevarnm = "&datevar";

				/** CREATE VARIABLE FROM THE STRING WITH THE NAME OF THE DATEVAR VARIABLE **/   
				datevarv = cats(vvaluex(datevarnm));

				/** IF NUMERIC VARIABLE THEN CONVERT TO CHAR FIRST **/ 
				if symget(catx('_', datevarnm, 't')) = 'N' then datevarv_c = put(datevarv, 20.);
					                                       else datevarv_c = datevarv;

				/** CHECK THAT THE DATE IS IN DATE9 FORMAT **/    
				if prxmatch('/[0123]?\d(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)(19|20)?\d\d/i', datevarv_c)  then do;
				   datepart = put(input(datevarv_c, date9.), yymmdd10.);
				end;
				else

				/** CHECK THAT THE DATE IS IN YYMMDD10 FORMAT BASED ON DATEVAR LENGTH **/   
				if (prxmatch('/\d{4}-0[1-9]|1[012]-[0-2]\d|3[01]/', datevarv_c) and length(datevarv_c) = 10) or
				   (prxmatch('/\d{4}-0[1-9]|1[012]/', datevarv_c)               and length(datevarv_c) = 7)  or 
				   (prxmatch('/\d{4}/', datevarv_c)                             and length(datevarv_c) = 4)  then do;
				   datepart = datevarv_c;
				end;

				drop datevarv_c datevarnm datevarv;

			%end;

			/********************/
			/** TIME PART      **/
			/********************/
			%if &timevar_n > 1 %then %do;

				/** FOR HOURS AND MINUTES ONLY **/
				length timevarhourv_c $2 timevarminv_c $2 timevarhournm timevarminnm $30;

				/** VARIABLE NAMES AS STRINGS **/  
				timevarhournm = scan("&timevar", 1, ' ');
				timevarminnm  = scan("&timevar", 2, ' ');
				
				/** CREATE VARIABLE FROM THE STRING WITH THE NAME OF THE VARIABLE FOR EACH DATE PART **/  
				timevarhourv  = cats(vvaluex(timevarhournm));
				timevarminv   = cats(vvaluex(timevarminnm));
				
				/** IF NUMERIC VARIABLES THEN CONVERT TO CHAR FIRST **/ 
				if symget(catx('_', timevarhournm, 't')) = 'N' then timevarhourv_c = put(timevarhourv, 2.);
					                                           else timevarhourv_c = timevarhourv;
				if symget(catx('_', timevarminnm, 't')) = 'N'  then timevarminv_c  = put(timevarminv, 2.);
					                                           else timevarminv_c  = timevarminv;

				/** ATTACH LEADING ZEROES **/  
				if prxmatch('/(\d{1})/', timevarhourv_c) and length(cats(timevarhourv_c)) = 1  then timevarhourv_c = '0'||timevarhourv_c;
				if prxmatch('/(\d{1})/', timevarminv_c)  and length(cats(timevarminv_c))  = 1  then timevarminv_c  = '0'||timevarminv_c;
				
				/** IF INVALID FORMAT ENTERED **/    
				if prxmatch('/[0-1][0-9]|2[0-3]| /', timevarhourv_c) ne 1  and timevarhourv_c ne '' then do;
				    put "-------------------------------------------------------------------------------------------";
					put "WAR" "NING: INVALID HOUR: " timevarhourv_c= ". SET TO MISSING ";;
					put "-------------------------------------------------------------------------------------------";
					timevarhourv_c = '';
				end;
				if prxmatch('/[0-5][0-9]| /', timevarminv_c) ne 1 and timevarminv_c ne '' then do;
				    put "-------------------------------------------------------------------------------------------";
					put "WAR" "NING: INVALID MIN: " timevarminv_c= ". SET TO MISSING ";;
					put "-------------------------------------------------------------------------------------------";
					timevarminv_c = '';
				end;

				/** IF HOUR AND MIN MISSING  **/  
				if timevarhourv_c in ('') then timevarhourv_c = '-';
				if timevarminv_c  in ('') then timevarminv_c  = '-';
				
				timepart = catx(':',timevarhourv_c,timevarminv_c);

				drop timevarhourv_c  timevarminv_c  timevarhournm timevarminnm timevarhourv timevarminv;

				/** IF SECONDS SPECIFIED **/  
				%if &timevar_n = 3 %then %do;
					
					length timevarsecv_c $2 timevarsecnm $30;

					/** VARIABLE NAMES AS STRINGS **/  
					timevarsecnm = scan("&timevar", 3, ' ');
					
					/** CREATE VARIABLE FROM THE STRING WITH THE NAME OF THE VARIABLE FOR EACH DATE PART **/  
					timevarsecv  = cats(vvaluex(timevarsecnm));
								
					/** IF NUMERIC VARIABLES THEN CONVERT TO CHAR FIRST **/ 
					if symget(catx('_', timevarsecnm, 't')) = 'N' then timevarsecv_c = put(timevarsecv, 2.);
			                                           		      else timevarsecv_c = timevarsecv;

					/** ATTACH LEADING ZEROES **/ 	
					if prxmatch('/(\d{1})/', timevarsecv_c) and length(cats(timevarsecv_c)) = 1  then timevarsecv_c = '0'||timevarsecv_c;

					/** IF INVALID FORMAT ENTERED FOR SECONDS **/  
					if prxmatch('/[0-5][0-9]| /', timevarsecv_c) ne 1 then do;
					    put "-------------------------------------------------------------------------------------------";
						put "WAR" "NING: INVALID SEC: " timevarsecv_c= ". SET TO MISSING ";
						put "-------------------------------------------------------------------------------------------";
						timevarsecv_c = '';
					end;

					/** IF SEC MISSING **/   
					if timevarsecv_c  = '' then timevarsecv_c = '';
								
					if timevarsecv_c ne '' then timepart = catx(':',timepart,timevarsecv_c);

					drop timevarsecv_c timevarsecnm timevarsecv;

				%end;
				
			%end;
			%else %if &timevar_n = 1 %then %do;
				length timevarv_c $8 timevarnm $30 ;

				/** VARIABLE NAMES AS STRINGS **/   
				timevarnm = "&timevar";

				/** CREATE VARIABLE FROM THE STRING WITH THE NAME OF THE TIMEVAR VARIABLE **/  
				timevarv  = cats(vvaluex(timevarnm));
				
				/** IF NUMERIC VARIABLE THEN CONVERT TO CHAR FIRST     **/
				/** ADD LEADING 0 WHEN HOURS ENTRED AS SINGLE DIGIT    **/ 
				if symget(catx('_', timevarnm, 't')) = 'N' then do;
				   if timevarv ne '' then do;
				      timevarv_c = put(input(&timevar,best.),time8.);
					  if length(cats(scan(timevarv_c,1,':'))) = 1 then timevarv_c = '0'||cats(timevarv_c);
				   end;
				end;
				else timevarv_c = timevarv;

				/** CHECK THAT THE TIME IS IN HH:MM:SS FORMAT, SECONDS ARE OPTIONAL **/   
                if length(timevarv_c) ge 2 then timevarhourv_c = substr(timevarv_c,1,2);
                if length(timevarv_c) ge 5 then timevarminv_c  = substr(timevarv_c,4,2);
                if length(timevarv_c) ge 8 then timevarsecv_c  = substr(timevarv_c,7,2);

				/** IF INVALID FORMAT ENTERED **/    
				if prxmatch('/[0-1][0-9]|2[0-3]| /', timevarhourv_c) ne 1  and timevarhourv_c ne '' then do;
				    put "-------------------------------------------------------------------------------------------";
					put "WAR" "NING: INVALID HOUR: " timevarhourv_c= ". SET TO MISSING ";;
					put "-------------------------------------------------------------------------------------------";
					timevarhourv_c = '-';
				end;
				if prxmatch('/[0-5][0-9]| /', timevarminv_c) ne 1 and timevarminv_c ne '' then do;
				    put "-------------------------------------------------------------------------------------------";
					put "WAR" "NING: INVALID MIN: " timevarminv_c= ". SET TO MISSING ";;
					put "-------------------------------------------------------------------------------------------";
					timevarminv_c = '-';
				end;
				if prxmatch('/[0-5][0-9]| /', timevarsecv_c) ne 1 then do;
					put "-------------------------------------------------------------------------------------------";
					put "WAR" "NING: INVALID SEC: " timevarsecv_c= ". SET TO MISSING ";
					put "-------------------------------------------------------------------------------------------";
					timevarsecv_c = '';
				end;

				if timevarhourv_c in ('') then timevarhourv_c = '-';
				if timevarminv_c  in ('') then timevarminv_c  = '-';
				
				timepart = catx(':',timevarhourv_c,timevarminv_c);

				if timevarsecv_c ne '' then timepart = catx(':',timepart,timevarsecv_c);

                if timevarsecv_c eq '' and timevarminv_c = '-' and timevarhourv_c ne '-' then timepart = timevarhourv_c;

				drop timevarv_c timevarnm timevarv timevarhourv_c timevarminv_c timevarsecv_c;	
			%end;
			
			/****************************************************/
          	/** COMBINE DATE AND TIME PARTS                    **/ 
	        /****************************************************/
			if timepart in ('','.','-:-') then &isovar = datepart;
			else 
            if datepart = ''              then &isovar = '-----T'||timepart;
			else do;
			   if length(datepart) = 4 then datepart = strip(datepart)||"----";
			   if length(datepart) = 7 and datepart not =: "-" 
                                       then datepart = strip(datepart)||"--";
               &isovar = catx('T', datepart, timepart);
			end;

			if &isovar = '-----'                                     then &isovar = '';
			if &isovar = '-----TIN:IN:IN'                            then &isovar = '';
			if index(&isovar,'T') = 0 and substr(&isovar,5) = '----' then &isovar = substr(&isovar,1,4);
			if index(&isovar,'T') = 0 and substr(&isovar,8) = '--'   then &isovar = substr(&isovar,1,7);
			
		%end;
		drop timepart datepart;
	run;
	
	******************************************************;
	*   DELETE TEMPORARY DATASETS                        *;
	******************************************************;
	proc datasets nolist;
		delete cont_&indsn &indsn1;
	run;
	quit;
	
%end; 
%mend m_isodtc_v1;
