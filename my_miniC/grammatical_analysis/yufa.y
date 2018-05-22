
%{  
#include<stdio.h>  
#include<ctype.h> 
#include<string.h>
//#define YYSTYPE char*

void yyerror(char *s);
void outinfo(int i);
%}  

%token NUM 
%token ID

%left '+' '-' 

%left '*' '/' 

%%  

lines:expr'\n'    {printf("success!\n");return;} 
     ;  

expr:expr '+' term      {outinfo(1);}

    |expr '-' term          {outinfo(2);} 

    |term                    {outinfo(3);} 

    ;  

term:term '*'factor      {outinfo(4);} 

     |term '/'factor          {outinfo(5);} 

     |factor                   {outinfo(6);} 

     ;  

factor:ID             {printf("F！！>id\n");}

       |'('expr')'           {outinfo(7);} 

       |NUM                  {printf("F！！>num\n");} 
       ; 

%% 

 #include"lex.yy.c" 

int main(void) 
   { 
      printf("continue?(1,yes;0,no)");
      int choice;
      scanf("%d",&choice);
      while(choice)
     {
       getchar();
       yyparse();
       printf("continue?(1,yes;0,no)");
       scanf("%d",&choice);     
     }
    return 0;
}
 


void outinfo(int i)
{
    switch(i)
    {
        case 1:{printf("E！！>E+T\n");break;}
	case 2:{printf("E！！>E-T\n");break;}
        case 3:{printf("E！！>T\n");break;}
        case 4:{printf("T！！>T*F\n");break;}
	case 5:{printf("T！！>T/F\n");break;}
	case 6:{printf("T！！>F\n");break;}
	case 7:{printf("F！！>(E)\n");break;}
     }
}

void yyerror(char *s)
{ 
	
   printf("%s\n",s); 

}  
