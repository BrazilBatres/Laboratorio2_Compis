%{
	#include <ctype.h>
	#include <stdio.h>
	#define YYSTYPE double /* double type for Yacc stack */
	
	extern int yylex();
	void yyerror(char *msg);
%}

%token OR
%token AND
%token NOT
%token TRUE
%token FALSE

%%
lines	: lines bexpr '\n' { 
								if( $2 == 1 )
								{
									printf("true (1)\n");
								}
								else
								{
									printf("false (0)\n");
								}
							}
		| lines '\n'
		| /* empty */
		;
		
bexpr	: bexpr OR bterm 	{ if($1 == 0 && $3 == 0)
								{
									$$=0;
								}
								else
								{
									$$=1;
								} 
							}	
		| bterm { $$ = $1 }
		;
		
bterm	: bterm AND bfactor	{ $$ = $1 * $3}
		| bfactor	{ $$ = $1 }
		;
		
bfactor	: NOT bfactor		{
								if( $2 == 1 )
								{
									$$ = 0;
								}
								else
								{
									$$ = 1;
								}
							}
		| '(' bexpr ')'		{ $$ = $2 }
		| TRUE				
		| FALSE				
		;
		
%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}