 /*+------------------------------------------------------+
   |          S A S   S A M P L E   L I B R A R Y         |
   |                                                      |
   |    NAME: GRRCALEN                                    |
   |   TITLE: GRRCALEN-Creating a Calendar Chart          |
   | PRODUCT: GRAPH                                       |
   |  SYSTEM: ALL                                         |
   |    KEYS: GRAPHICS GRADAR                             |
   |   PROCS: GRADAR                                      |
   |    DATA: INTERNAL                                    |
   |                                                      |
   | SUPPORT: GRAPHICS STAFF        UPDATE: 28FEB11       |
   |     REF: SAS/GRAPH REFERENCE GUIDE                   |
   +------------------------------------------------------+*/

 /* The CALENDAR option produces a radar chart displaying
    12 equal-sized segments, one for each month of the year
    JAN through DEC. The color shading of each segment
    represents the magnitude of the frequency variable. Use
    the OVERLAY variable to subdivide each segment,
    for example, by year.
 */

goptions reset=all border;

data climate;
   input Year Month $ Temperature @@;
datalines;
2006 Jan 16 2006 Feb 19 2006 Mar 22 2006 Apr 33
2006 May 41 2006 Jun 60 2006 Jul 55 2006 Aug 41
2006 Sep 38 2006 Oct 30 2006 Nov 27 2006 Dec 20
2007 Jan 18 2007 Feb 23 2007 Mar 20 2007 Apr 27
2007 May 33 2007 Jun 52 2007 Jul 55 2007 Aug 38
2007 Sep 38 2007 Oct 27 2007 Nov 26 2007 Dec 19
run;

proc gradar data=climate;
    chart month / freq=temperature
       calendar
       overlayvar=year;
    run;
quit;
