%token COMMONNAME
%token IS
%token HASHTAG
%token PERCENTAGE
%token NONQUESTION
%token SPACE
%token ASSIGN
%token PLUS
%token RIGHTARROW
%token LEFTARROW
%token DOUBLEARROW
%token DOUBLEDASH
%token MINUS
%token MUL
%token DIV
%token COMMA
%token DOT
%token LT
%token GT
%token LTE
%token GTE
%token NOT
%token POW
%token LPARAN
%token RPARAN
%token LBRACE
%token RBRACE
%token LBRACKET
%token RBRACKET
%token DIGIT
%token LETTER
%token NEWLINE
%token NONSTAR
%token NONSTARNONDIV
%token NONNEWLINE
%token UNDERSCORE
%token STRING
%token BOOL
%token SET
%token ID
%token INT
%token FLOAT
%token ENDSTMT
%token COMMENT
%token DIRECTEDGRAPH
%token UNDIRECTEDGRAPH
%token VERTEX
%token EDGE
%token QUESTION
%token AND
%token OR
%token CONSTANT


// Define the union that can hold different values for the tokens
 
%union 
{
  char * string;
  int integer;
}

// Define the token value types

%type <string> ID
// define associativity of operations

%left PLUS MINUS // the order defines precedence, 
%left STAR DIV // so * and / has higher precedence than + and -

%{ 
  #include <iostream> 
  #include <string>
  using namespace std;

  extern int yylineno;
  void yyerror(string);
  int yylex(void);
  int numoferr;
  
%}

%%

main:
	query_list

query_list:
	ID query query_list 
	| assignments query_list 
	| ID ASSIGN query_unit_list ENDSTMT query_list 
	| ID ASSIGN query_expression ENDSTMT query_list 
	| query {yyerror("Missing graph name");} 
	|

query: 
	QUESTION query_unit_list ENDSTMT
	| NONQUESTION {yyerror("? expected");}
	|  QUESTION query_expression ENDSTMT  

query_unit_list:
	query_unit query_unit_list 
	| 

query_unit:
	edge_query 
	| vertex_query 
	| check_property {yyerror("Queries must be within \"% exp %\" or \"[ exp ]\"");}
	
edge_query:
	 PERCENTAGE check_property PERCENTAGE
	
vertex_query:
	LBRACKET check_property RBRACKET

query_expression:
	 ID OR ID
	| ID query_expression
	|

check_property:
	conditional operator expr 
	| BOOL 
	| ID operator expr {yyerror("Property names must be in \" \"");}

conditional:
	STRING
	| ID {yyerror("Property names must be in \" \"");}

expr:
	STRING 
	| INT 
	| FLOAT 
	| ID arithmetic ID 
	| ID 
	| CONSTANT ID
	| LPARAN STRING OR STRING RPARAN
	| COMMONNAME
	
operator:
	IS 
	| LT 
	| GT 
	| LTE 
	| GTE 
	| arithmetic {yyerror("Expected boolean expression for queries");}

arithmetic:
	PLUS 
	| MINUS 
	| DIV 
	| MUL 

assignments:
	ID ASSIGN INT ENDSTMT;
	
%%


extern int yylineno;
void yyerror(string s) 
{
	numoferr++;
	cout << "error at line " << yylineno << ": " << s << endl;
}
int main()
{
	numoferr=0;
	yyparse();
	if(numoferr>0) {
		cout << "Parsing completed with " << numoferr << " errors" << endl;
	} else {
		cout << "Successfully parsed" << endl;
	}
	return 0;
}

