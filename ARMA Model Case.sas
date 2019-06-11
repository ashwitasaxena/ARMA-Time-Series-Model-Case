DATA CASE;
DO YEAR=1955 TO 1979;
   DO QUARTER=1 TO 4;
      DATE=YYQ(YEAR,QUARTER);
      INPUT SAVING @@;ONE=1; OUTPUT;
   END;
END;
KEEP DATE SAVING ONE; FORMAT DATE YYQ4.;
*LABEL SAVING=(PERSONAL SAVING/DISPOSABLE INCOME)*100;
CARDS;
4.9 5.2 5.7 5.7 6.2 6.7 6.9 7.1 6.6 7 6.9 6.4 6.6 6.4 7 7.3 6 6.3 4.8
5.3 5.4 4.7 4.9 4.4 5.1 5.3 6 5.9 5.9 5.6 5.3 4.5 4.7 4.6 4.3 5 5.2
6.2 5.8 6.7 5.7 6.1 7.2 6.5 6.1 6.3 6.4 7 7.6 7.2 7.5
7.8 7.2 7.5 5.6 5.7 4.9 5.1 6.2 6 6.1 7.5 7.8 8 8 8.1 7.6 7.1
6.6 5.6 5.9 6.6 6.8 7.8 7.9 8.7 7.7 7.3 6.7 7.5 6.4 9.7 7.5 7.1 6.4
6 5.7 5 4.2 5.1 5.4 5.1 5.3 5 4.8 4.7 5 5.4 4.3 3.5
;
PROC PRINT; RUN;

/*identification of model */

PROC ARIMA; 
	IDENTIFY VAR=SAVING; 
RUN;

/*parameter estimation */
/* residual diagnostic*/
proc arima; 
	identify var=SAVING minic; 
	estimate p=1; 
run;

/*checking MA */
proc arima; 
	identify var=SAVING; 
	estimate p=1 q=2 ; 
run;

/* fittitng MA at lag 2*/
 
proc arima; 
	identify var=SAVING; 
	estimate p=1 q=(2) ; 
run;


/* forecast */

proc arima; 
	identify var=SAVING; 
	estimate p=1 q=(2)  method=cls; 
run; 
forecast lead=8 out=output; 
quit; 









