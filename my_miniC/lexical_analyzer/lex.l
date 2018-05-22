%{
 #include <ctype.h>
 #include <stdio.h> 
 #include <string.h> 
 #include <stdlib.h>
void comment(); 
int yywrap(); 
  int lineno=1;
  int wcount=0;
  int ccount=0;
  int er=1,ec=1,ec1=1;
%}
letter[A-Za-z]   
digit[0-9]      
id({letter}|_)({letter}|{digit}|_)*  
error_id({digit})+({letter})+ 
num{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?                   
whitespace[ ]
space [\t]          
enter[\n]            
%%  
"include"|"main"|"int"|"float"|"double"|"char"|"long"|"bool"|"short"|"if"|"else"|"for"|"while"|"do"|"struct"|"typedef"|"const"|"default"|"return"|"case"|"switch"|"break"|"continue"|"enum"|"goto"|"sizeof"|"static"|"void"|"union"|"unsigned"|"signed"|"volatil" {ec=ec+yyleng;Upper(yytext,yyleng); 
                                             printf("%d 行   ",lineno); 
                                             printf("%s			reserved word\n",yytext);}
{num}   {ccount=ccount+yyleng;ec=ec+yyleng;wcount++;printf("%d 行   ",lineno); 
         printf("%s			NUM\n",yytext);}
"<"|">"|"="|">="|"<="|"=="|"!="                        {ec=ec+yyleng;ccount=ccount+yyleng;wcount++;printf("%d 行   ",lineno);
                                    printf("%s			relop operator\n",yytext);}
"&"|"||"|"!"			   {ec=ec+yyleng;ccount=ccount+yyleng;wcount++;printf("%d 行   ",lineno);
                                    printf("%s			logic operator\n",yytext);}
"+"|"-"|"*"|"/"			   {ec=ec+1;ccount++;wcount++;printf("%d 行   ",lineno);
                                    printf("%s			arithmetic operator\n",yytext);}
","|";"				   {ec++;ccount++;printf("%d 行   ",lineno);printf("%s			punctuation mark\n",yytext);}
"("|")"|"{"|"}"|"#"|"."|"%"|"\\"|"["|"]"|"\""    {ec=ec+yyleng;ccount=ccount+yyleng;printf("%d 行   ",lineno);
                                                                                    printf("%s			special symbol\n",yytext);}
"/*"                {printf("%d 行    ",lineno);printf("/*");comment();printf("		comment statement\n");}
{id}                  {ccount=ccount+yyleng; wcount++;ec=ec+yyleng;printf("%d 行   ",lineno); 
                       printf("%s			ID\n",yytext);}
{error_id}          { ec=ec+yyleng;wcount++;ccount=ccount+yyleng;printf("%d 行   ",lineno);er=lineno;
                       printf("error:			%s\n",yytext);
			ec1=ec-yyleng;
			printf("line:%d,col:%d\n",er,ec1);}
 {whitespace}          {ec=ec+1;}
 {space}                {ec=ec+8;}
 {enter}              {lineno++;ec=1;}
%%  
 Upper(char *s,int l)
 {   int i; 
     ccount=ccount+l;
     wcount=wcount+1;
    for(i=0;i<l;i++){s[i]=toupper(s[i]); } 
  } 
void comment()
{
       
           char ch=input();
                while (ch!='*')
                 {printf("%c",ch);
  		  ch=input();
		 }
                while(ch!='/')
                 {printf("%c",ch);
 		  ch=input();
		 }
		printf("/");
                return;
}

int yywrap() 
{ 
   return(1); 
} 

 main(void) {    
    FILE *infile;
    char infileName[200];
    printf("Please input the file Name: ");
    scanf("%s",&infileName);
    infile=fopen(infileName,"r");
    yyin=infile;  
   printf("开始词法分析： \n");  
   yylex();
   lineno=lineno-1;
   printf("Line:%d\n",lineno);
   printf("word count:%d\n",wcount);
   printf("char count:%d\n",ccount);
    return 258;
}