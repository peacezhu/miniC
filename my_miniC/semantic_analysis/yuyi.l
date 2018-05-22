%option noyywrap 
%{

 #include <ctype.h>
 #include <stdio.h> 
 #include <stdlib.h> 
 #include<string.h> 
 #include "yuyi.tab.h"

%}

digit[0-9]  
r{digit}+[.]{digit}+   
num{digit}+
whitespace[ ]+ 
enter[\n]                
%% 
{r} {yylval.realnum=atof(yytext);	
	yylval.c.c=2;return REAL;} 
{num}   {yylval.num=atoi(yytext); yylval.c.c=0;return NUM;}
"/"     {return ('/');}
"*"     {return ('*');}
"("     {return ('(');}
")"     {return (')');}
"+"     {return ('+');}
"-"     {return ('-');}                                    
{whitespace}          {/* skip whitespace */}
 {enter}         {return('\n');}
%%  



  