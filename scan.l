%{
#include<iostream>
#include "y.tab.h"
using namespace std;
int yyparse();
%}
%option yylineno

PERCENTAGE %
SPACE [ \t]+
ASSIGN =
PLUS \+
RIGHTARROW ->
DOUBLEDASH --
MINUS -
MUL \*
DIV \/
COMMA ,
HASHTAG \#
DOT \.
LT <
GT >
LTE <=
GTE >=
NOT NOT
POW \^
LPARAN \(
RPARAN \)
LBRACE \{
RBRACE \}
LBRACKET \[
RBRACKET \]
DIGIT [0-9]
LETTER [a-zA-Z]
NEWLINE \n
NONNEWLINE [^\n]
UNDERSCORE _
STRING \"([^\\\"]|\\\\|\\\"|\\t|\\n)*\"
BOOL true|false
ID ({LETTER}|{UNDERSCORE})({LETTER}|{DIGIT}|{UNDERSCORE})*
INT ({MINUS}|{PLUS})?{DIGIT}+
FLOAT {INT}"."{DIGIT}+
ENDSTMT ;
COMMENT {HASHTAG}+{NONNEWLINE}*\n
DIRECTEDGRAPH DirectedGraph
UNDIRECTEDGRAPH UndirectedGraph
VERTEX vertex
EDGE edge
SET set
QUESTION \?
NONQUESTION \!
AND AND
OR OR
IS IS
COMMONNAME @{ID}


%%
{NONQUESTION} return NONQUESTION;
{PERCENTAGE} return PERCENTAGE;
{COMMONNAME} return COMMONNAME;
{IS} return IS;
{SET} return SET;
{DIRECTEDGRAPH} return DIRECTEDGRAPH;
{UNDIRECTEDGRAPH} return UNDIRECTEDGRAPH;
{VERTEX} return VERTEX;
{EDGE} return EDGE;
{DOUBLEDASH} return DOUBLEDASH;
{RIGHTARROW} return RIGHTARROW;
{QUESTION} return QUESTION;
{AND} return AND;
{OR} return OR;
{DOT} return DOT;
{SPACE} ;
{COMMENT} ;
{COMMA} return COMMA;
{NEWLINE} ;
{ENDSTMT} return ENDSTMT;
{ASSIGN} return ASSIGN;
{NOT} return NOT;
{LTE} return LTE;
{GTE} return GTE;
{LT} return LT;
{GT} return GT;
{POW} return POW;
{LBRACE} return LBRACE;
{RBRACE} return RBRACE;
{PLUS} return PLUS;
{MINUS} return MINUS;
{MUL} return STAR;
{DIV} return DIV;
{LPARAN} return LPARAN;
{RPARAN} return RPARAN;
{LBRACKET} return LBRACKET;
{RBRACKET} return RBRACKET;
{STRING} return STRING;
{BOOL} return BOOL;
{INT} return INT;
{FLOAT} return FLOAT;
{ID} return ID;

%%
int yywrap()
{
	return 1;
}