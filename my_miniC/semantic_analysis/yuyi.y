%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>


typedef struct x
{int i;
 double f;
 int c;
}type;


void yyerror(char *s);
void error();
%}
%union{
 int  num;
 double realnum;
 type c;
}

%token <num> NUM
%token <realnum> REAL
%type<c>expr term factor
%%
line:expr '\n'
	{
	if($1.c==0)
		printf("%d integer\nsuccess!\n",$1.i);
	else if($1.c==2)
		printf("%f real\nsuccess!\n",$1.f);
	return 1;
	}
	;
expr:expr '+' term
	
	{if($1.c==$3.c){
	if($1.c==0 && $3.c==0)
	{
		$$.i=$1.i+$3.i;
		$$.c=0;
		printf("E->E+T	E.type:integer\tE.num=%d\n",$$.i);
	}
	else if($1.c==2 && $3.c==2)
	{
		$$.f=$1.f+$3.f;
		$$.c=2;
		printf("E->E+T	E.type:real\tE.real=%f\n",$$.f);
	}
	
	}
	else {error();if($1.c==0){$1.c=2;$1.f=$1.i+0.0;$$.f=$1.f+$3.f;$$.c=2;
		printf("E->E+T	E1.type:integer转real  E.type:real\tE.real=%f\n",$$.f);}
               else if($3.c==0){$3.c=2;$3.f=$3.i+0.0;$$.f=$1.f+$3.f;$$.c=2;
		printf("E->E+T	T1.type:integer转real  E.type:real\tE.real=%f\n",$$.f);}
	}   
	}
    |expr '-' term
	{
	if($1.c==$3.c){
	if($1.c==0 && $3.c==0)
	{
		$$.i=$1.i-$3.i;
		$$.c=0;
		printf("E->E-T	E.type:integer\tE.num=%d\n",$$.i);
	}
	else if($1.c==2 && $3.c==2)
	{
		$$.f=$1.f-$3.f;
		$$.c=2;
		printf("E->E-T	E.type:real\tE.real=%f\n",$$.f);
	}
	}
	else{error();if($1.c==0){$1.c=2;$1.f=$1.i+0.0;$$.f=$1.f-$3.f;$$.c=2;
		printf("E->E-T	E1.type:integer转real  E.type:real\tE.real=%f\n",$$.f);}
               else if($3.c==0){$3.c=2;$3.f=$3.i+0.0;$$.f=$1.f-$3.f;$$.c=2;
		printf("E->E-T	T1.type:integer转real  E.type:real\tE.real=%f\n",$$.f);}
	}   
	}
    |term
	{
 	$$.c=$1.c;
	if($$.c==0){
		$$.i=$1.i;
		printf("E->T	E.type:integer\tE.num=%d\n",$$.i);}
	else if($$.c==2){
		$$.f=$1.f;
		printf("E->T	E.type:real\tE.real=%f\n",$$.f);}
	
	}
	;
term:term '*' factor
	{
	if($1.c==$3.c){
	if($1.c==0 && $3.c==0)
	{
		$$.i=$1.i*$3.i;
		$$.c=0;
		printf("T->T*F	T.type:num\tT.num=%d\n",$$.i);
	}
	else if($1.c==2 && $3.c==2)
	{
		$$.f=$1.f*$3.f;
		$$.c=2;
		printf("T->T*F	T.type:real\tT.real=%f\n",$$.f);
	}
	}
	else{error();if($1.c==0){$1.c=2;$1.f=$1.i+0.0;$$.f=$1.f*$3.f;$$.c=2;
		printf("T->T*F	T1.type:integer转real  T.type:real\tT.real=%f\n",$$.f);}
               else if($3.c==0){$3.c=2;$3.f=$3.i+0.0;$$.f=$1.f*$3.f;$$.c=2;
		printf("T->T*F	F1.type:integer转real  T.type:real\tT.real=%f\n",$$.f);}
	}
	}	       
	|term '/' factor
	{
	if($1.c==$3.c){
	if($1.c==0 && $3.c==0)
	{
		$$.i=$1.i/$3.i;
		$$.c=0;
		printf("T->T/F	T.type:integer\tT.num=%d\n",$$.i);
	}
	else if($1.c==2 && $3.c==2)
	{
		$$.f=$1.f/$3.f;
		$$.c=2;
		printf("T->T/F	T.type:real\tT.real=%f\n",$$.f);
	}
	}
	else{error();if($1.c==0){$1.c=2;$1.f=$1.i+0.0;$$.f=$1.f/$3.f;$$.c=2;
		printf("T->T/F	T1.type:integer转real  T.type:real\tT.real=%f\n",$$.f);}
               else if($3.c==0){$3.c=2;$3.f=$3.i+0.0;$$.f=$1.f/$3.f;$$.c=2;
		printf("T->T/F	F1.type:integer转real  T.type:real\tT.real=%f\n",$$.f);}
	}
	}
	|factor
	{
 	$$.c=$1.c;
	if($$.c==0){
		$$.i=$1.i;
		printf("T->F	T.type:integer\tT.num=%d\n",$$.i);}
	else if($$.c==2){
		$$.f=$1.f;
		printf("T->F	T.type:real\tT.real=%f\n",$$.f);}
	}
	;
factor:REAL  {$$.c=2;$$.f=$1;
		printf("F->num.num	F.type:real\tF.real=%f\n",$$.f);}
	|'(' expr ')'
	{
	$$.c=$2.c;
	if($$.c==0){
		$$.i=$2.i;
		printf("F->(E)	F.type:integer\tF.num=%d\n",$$.i);}
	else if($$.c==2){
		$$.f=$2.f;
		printf("F->(E)	F.type:real\tF.real=%f\n",$$.f);}
	}
	|NUM   {$$.c=0;$$.i=$1;
		printf("F->num  F.type:integer\tF.num=%d\n",$$.i);}
	;

%%

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
 

#include"lex.yy.c" 

void yyerror(char *s)
{ 	
   printf("%s\n",s); 
} 

void error()
{
	printf("类型不匹配！\n");
}

