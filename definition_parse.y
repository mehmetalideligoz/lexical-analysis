%token COMMONNAME
%token IS
%token NONQUESTION
%token PERCENTAGE
%token SPACE
%token ASSIGN
%token PLUS
%token RIGHTARROW
%token DOUBLEDASH
%token MINUS
%token MUL
%token DIV
%token COMMA
%token HASHTAG
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
%token NONSTRING
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

// Define the union that can hold different values for the tokens
%union 
{
  char * string;
  int integer;
}


// Token value type
%type <string> ID

// Set Associativity
%left PLUS MINUS  
%left STAR DIV 

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

main :
	definition_list

// Allows multiple graphs in main program
definition_list:
	definition definition_list 
	|

// A definition can be either undirected or directed graph
definition:
	undirected_definition 
	| directed_definition 
	| ID ASSIGN LBRACE ud_graph RBRACE {yyerror("Specify the type of graph: directed or undirected");}

// Directed graph definition and undirected graph definition must be seperated.
undirected_definition:
    UNDIRECTEDGRAPH ID ASSIGN LBRACE ud_graph RBRACE 
    | UNDIRECTEDGRAPH ID ASSIGN LBRACE ud_graph {yyerror("Unmatched brace");}

directed_definition:
	DIRECTEDGRAPH ID ASSIGN LBRACE d_graph RBRACE 
	| DIRECTEDGRAPH ID ASSIGN LBRACE d_graph {yyerror("Unmatched brace");}
	
ud_graph:
	ud_unit_list
	
d_graph:
	d_unit_list 

ud_unit_list:
	ud_unit ud_unit_list 
	| 
	
d_unit_list:
	d_unit d_unit_list 
	|

ud_unit:
	pre_ud_unit ENDSTMT 
	| pre_ud_unit {yyerror("Missing semicolon ';'");} 

pre_ud_unit:
	VERTEX id_list 
	| undirected_edge_definition 
	| directed_edge_definition {yyerror("Type mismatch: expected undirected edge definition");}
 	| undirected_edge_property 
 	| vertex_property_addition
	
d_unit:
	pre_d_unit ENDSTMT 
	| pre_d_unit {yyerror("Missing semicolon ';'");} 
	|  vertex_property_addition

pre_d_unit:
	VERTEX id_list  
	| directed_edge_definition
	| undirected_edge_definition {yyerror("Type mismatch: expected directed edge definition");} 
	| directed_edge_property 
	| vertex_property_addition


// 
directed_edge_property:
	ID LBRACKET STRING RBRACKET ASSIGN expr  
	| ID LBRACKET RBRACKET ASSIGN expr {yyerror("type mismatch: expected directed edge definition");} 
	| LPARAN ID arrow ID RPARAN LBRACKET STRING RBRACKET ASSIGN expr 

undirected_edge_property:
	ID LBRACKET STRING RBRACKET ASSIGN expr  
	| LPARAN ID DOUBLEDASH ID RPARAN LBRACKET STRING RBRACKET ASSIGN expr 
	
	

// directed edge undirected edge
directed_edge_definition:
	EDGE ID LBRACE property_list RBRACE 
	| EDGE id_list  
	| EDGE ID ASSIGN ID arrow ID  
	|ID directed_id_tail  
	| ID ASSIGN ID arrow ID 
 
undirected_edge_definition:
	EDGE ID LBRACE property_list RBRACE 
	| EDGE id_list  
	| EDGE ID ASSIGN ID DOUBLEDASH ID  
	| ID undirected_id_tail 
	| ID ASSIGN ID DOUBLEDASH ID 
	| ID ASSIGN ID arrow ID {yyerror("Expected undirected edge '--'");} 
	
// directed and undirected id_tail
undirected_id_tail:
	DOUBLEDASH ID undirected_id_tail
	| 

directed_id_tail:
	arrow ID directed_id_tail 
	| 

	
vertex_property_addition:
	VERTEX ID LBRACE property_list RBRACE 
	| ID LBRACE property_list RBRACE {yyerror("You have to specify the type of definition: edge or vertex");} 

// Example id_list: vertex a,b,c,d;
id_list:
	ID id_list_tail 

id_list_tail:
	COMMA ID id_list_tail  
	|

// Vertices and edges can take multiple properties. 
property_list:
	property property_list 
	|

property:
	STRING ASSIGN expr ENDSTMT 
	| ASSIGN expr ENDSTMT {yyerror("String is expected as a property name");} 

arrow:
	RIGHTARROW
		
expr:
	ID 
	| STRING 
	| INT 
	| FLOAT 
	| BOOL 
	| SET LBRACKET set_elements RBRACKET

// Example set: ["mehmetali", 3, 5, 0.5, true]
set_elements:
	expr set_elements_tails

set_elements_tails:
	COMMA expr set_elements_tails 
	|

%%

// report errors
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


