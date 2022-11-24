/* Data Step Processing*/

/*

Compilation Phase:
		1. Syntax check
		2. Creates input buffer
		3. Creates PDV
		4. Creates Descriptor Information

	1. Input buffer - Logical memory area reads each record when execure input statement.
					- Creates only when reads raw data.

	2. PDV - Logical area in memory where SAS builds a data set, one observation at a time.
		   - The data values are assigned to the appropriate variables in the program data vector.
		   - PDV contains two automatic variables, _N_ and _ERROR_.
		   - SAS does not write these variables to the output data set.
	
	3. Descriptor Information - Creates data set attributes and variable attributes.
							  - The descriptor information also contains information about extended attributes(if defined on a data set). 

Execution Phase:
	- The DATA step begins with a DATA statement. 
	- Each time the DATA statement executes, a new iteration of the DATA step begins, and the _N_ automatic variable is incremented by 1.
	- SAS sets the newly created program variables to missing in the program data vector (PDV).
	- SAS reads a data record from a raw data file into the input buffer, or it reads an observation from a SAS data set directly into the program data vector. 
	- You can use an INPUT, MERGE, SET, MODIFY, or UPDATE statement to read a record.
	- At the end of the statements, an output, return, and reset occur automatically.
	- the values of variables created by INPUT and assignment statements are reset to missing in the program data vector.
	- Note that variables that you read with a SET, MERGE, MODIFY, or UPDATE statement are not reset to missing here.
	- SAS counts another iteration, reads the next record or observation, and executes the subsequent programming statements for the current observation.
	- The DATA step terminates when SAS encounters the end-of-file in a SAS data set or a raw data file.

*/

proc printto log = "E:\NewDisk\SAS\My SAS\Base SAS\Data Step\log\pdv.log"
			 print="E:\NewDisk\SAS\My SAS\Base SAS\Data Step\lst\pdv.lst";
run;


data total_points (drop=TeamName); 
put _all_;
 input TeamName $ ParticipantName $ Event1 Event2 Event3; 
 TeamTotal + (Event1 + Event2 + Event3); 
put _all_;
 datalines;
Knights Sue 6 8 8
Kings Jane 9 7 8
Knights John 7 7 7
Knights Lisa 8 9 9
Knights Fran 7 6 6
Knights Walter 9 8 10
;

data total_points1 (drop=TeamName); 
put _all_;
 input TeamName $ ParticipantName $ Event1 Event2 Event3; 
 TeamTotal + sum(of Event1, Event2, Event3); 
put _all_;
 datalines;
Knights Sue 6 8 8
Kings Jane 9 7 8
Knights John 7 7 7
Knights Lisa 8 9 9
Knights Fran 7 6 6
Knights Walter 9 8 10
;

data points (drop=TeamName); 
 input TeamName $ ParticipantName $ Event1 Event2 Event3; 
 datalines;
Knights Sue 6 8 8
Kings Jane 9 7 8
Knights John 7 7 7
Knights Lisa 8 9 9
Knights Fran 7 6 6
Knights Walter 9 8 10
;

data team_points2;
	put _all_;
	set points;
	TeamTotal + sum(of Event1, Event2, Event3); 
	put _all_;
run;

 data grades;
 put _all_;
 StudentID=101; Class="A"; English=80; Math=70; output;
 put _all_;
 StudentID=102; Class="B"; English=. ; Math=60; output;
 put _all_;
 StudentID=103; Class="A"; English=70; Math=. ; output;
 put _all_;
 StudentID=104; Class="A"; English=80; Math=95; output;
 put _all_;
 StudentID=105; Class="B"; English=90; Math=80; output;
 put _all_;
 run;

 data example3;
 put _all_;
 set grades;
 length eng_cnt math_cnt average 8 ;
 if English > . then eng_cnt=1 ; else Eng_cnt=0 ;
 if Math > . then math_cnt=1 ;
 class_cnt = sum (eng_cnt, math_cnt) ;
 average = sum (English, Math) / class_cnt ;
 put _all_;
 run;

proc printto;
run;
