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
