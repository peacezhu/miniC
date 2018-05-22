%option noyywrap 
%{

 #include <ctype.h>
 #include <stdio.h> 
 #include <stdlib.h> 
 #include<string.h> 
 #include "yufa.tab.h"

%}

id[A-Za-z]    
digit[0-9]  
num{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?    
whitespace[ \t]+ 
enter[\n]                
%%  
{num}   { return NUM;}
"/"     {return ('/');}
"*"     {return ('*');}
"("     {return ('(');}
")"     {return (')');}
"+"     {return ('+');}
"-"     {return ('-');}
{id}        {return ID;}                                                                                  
{whitespace}          {/* skip whitespace */}
 {enter}         {return('\n');}
%%  



  