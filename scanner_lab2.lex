true	[Tt][Rr][Uu][Ee]
false	[Ff][Aa][Ll][Ss][Ee]
or		[Oo][Rr]
and		[Aa][Nn][Dd]
not		[Nn][Oo][Tt]
%%
[ \t]		; { /* Espacios en blanco */ }
[\(\)\n]	return yytext[0];
{true}		{
				sscanf("1", "%lf", &yylval);
				return TRUE;
			}
{false}		{
				sscanf("0", "%lf", &yylval);
				return FALSE;
			}
{or}			return OR;
{and}			return AND;
{not}			return NOT;	
.			printf("Error\n");
%%

int yywrap(void)
{
	return 0;
}
/*main(){
	int token;
	token = yylex();
	while (token){
		printf("%d\n", token);
		token = yylex();
	}
}*/