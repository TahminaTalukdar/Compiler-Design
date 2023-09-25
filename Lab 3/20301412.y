%token DO BREAK CONTINUE CHAR DOUBLE SWITCH CASE DEFAULT
%{
#include <iostream>
#include <fstream>
#include "symbol_info.h"
std::ofstream outlog;

#define YYSTYPE symbol_info*


int lines = 1;
extern ofstream outlog;
extern FILE* yyin;

int yylex();
void yyerror(const char *);

%}

%token IF ELSE FOR WHILE PRINTLN RETURN INT FLOAT VOID ID CONST_INT CONST_FLOAT ADDOP MULOP RELOP LOGICOP ASSIGNOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD SEMICOLON COMMA INCOP DECOP
%left LOGICOP
%left RELOP
%left ADDOP SUBOP
%left MULOP DIVOP MODOP
%right NOT INCOP DECOP
%nonassoc ELSE

%start start

%%

start : program
	{
		outlog << "At line no: " << lines << " start : program " << std::endl << std::endl;
	}
	;

program : program unit
	{
		outlog << "At line no: " << lines << " program : program unit " << std::endl << std::endl;
		outlog << $1->getname() << "\n" << $2->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "\n" + $2->getname(), "program");
	}
	| unit
	{
		$$ = $1;
	}
	;

unit : var_declaration
	{
		$$ = $1;
	}
	| func_definition
	{
		$$ = $1;
	}
	;

func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		outlog << "At line no: " << lines << " func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement " << std::endl << std::endl;
		outlog << $1->getname() << " " << $2->getname() << "()\n" << $5->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + "()\n" + $5->getname(), "func_def");
	}
	| type_specifier ID LPAREN RPAREN compound_statement
	{
		outlog << "At line no: " << lines << " func_definition : type_specifier ID LPAREN RPAREN compound_statement " << std::endl << std::endl;
		outlog << $1->getname() << " " << $2->getname() << "()\n" << $5->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + "()\n" + $5->getname(), "func_def");
	}
	;

parameter_list : parameter_list COMMA type_specifier ID
	{
		outlog << "At line no: " << lines << " parameter_list : parameter_list COMMA type_specifier ID " << std::endl << std::endl;
		outlog << $1->getname() + ", " + $3->getname() + " " + $4->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ", " + $3->getname() + " " + $4->getname(), "param_list");
	}
	| parameter_list COMMA type_specifier
	{
		outlog << "At line no: " << lines << " parameter_list : parameter_list COMMA type_specifier " << std::endl << std::endl;
		outlog << $1->getname() + ", " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ", " + $3->getname(), "param_list");
	}
	| type_specifier ID
	{
		outlog << "At line no: " << lines << " parameter_list : type_specifier ID " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname(), "param_list");
	}
	| type_specifier
	{
		outlog << "At line no: " << lines << " parameter_list : type_specifier " << std::endl << std::endl;
		outlog << $1->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname(), "param_list");
	}
	;

compound_statement : LCURL statements RCURL
	{
		outlog << "At line no: " << lines << " compound_statement : LCURL statements RCURL " << std::endl << std::endl;
		outlog << "{\n" << $2->getname() << "}\n" << std::endl;
		$$ = new symbol_info("{\n" + $2->getname() + "}\n", "compound_stmnt");
	}
	| LCURL RCURL
	{
		outlog << "At line no: " << lines << " compound_statement : LCURL RCURL " << std::endl << std::endl;
		outlog << "{}\n" << std::endl;
		$$ = new symbol_info("{}\n", "compound_stmnt");
	}
	;

var_declaration : type_specifier declaration_list SEMICOLON
	{
		outlog << "At line no: " << lines << " var_declaration : type_specifier declaration_list SEMICOLON " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() + ";" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + ";", "var_decl");
	}
	;

type_specifier : INT
	{
		outlog << "At line no: " << lines << " type_specifier : INT " << std::endl << std::endl;
		outlog << "int" << std::endl << std::endl;
		$$ = new symbol_info("int", "type_specifier");
	}
	| FLOAT
	{
		outlog << "At line no: " << lines << " type_specifier : FLOAT " << std::endl << std::endl;
		outlog << "float" << std::endl << std::endl;
		$$ = new symbol_info("float", "type_specifier");
	}
	| VOID
	{
		outlog << "At line no: " << lines << " type_specifier : VOID " << std::endl << std::endl;
		outlog << "void" << std::endl << std::endl;
		$$ = new symbol_info("void", "type_specifier");
	}
	;

declaration_list : declaration_list COMMA ID
	{
		outlog << "At line no: " << lines << " declaration_list : declaration_list COMMA ID " << std::endl << std::endl;
		outlog << $1->getname() + ", " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ", " + $3->getname(), "decl_list");
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		outlog << "At line no: " << lines << " declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD " << std::endl << std::endl;
		outlog << $1->getname() + ", " + $3->getname() + "[" + $5->getname() + "]" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ", " + $3->getname() + "[" + $5->getname() + "]", "decl_list");
	}
	| ID
	{
		outlog << "At line no: " << lines << " declaration_list : ID " << std::endl << std::endl;
		outlog << $1->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname(), "decl_list");
	}
	| ID LTHIRD CONST_INT RTHIRD
	{
		outlog << "At line no: " << lines << " declaration_list : ID LTHIRD CONST_INT RTHIRD " << std::endl << std::endl;
		outlog << $1->getname() + "[" + $3->getname() + "]" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "[" + $3->getname() + "]", "decl_list");
	}
	;

statements : statement
	{
		$$ = $1;
	}
	| statements statement
	{
		$$ = new symbol_info($1->getname() + "\n" + $2->getname(), "statements");
	}
	;

statement : var_declaration
	{
		$$ = $1;
	}
	| expression_statement
	{
		$$ = $1;
	}
	| compound_statement
	{
		$$ = $1;
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		outlog << "At line no: " << lines << " statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement " << std::endl << std::endl;
		outlog << "for(" << $3->getname() << $4->getname() << $5->getname() << ")\n" << $7->getname() << std::endl << std::endl;
		$$ = new symbol_info("for(" + $3->getname() + $4->getname() + $5->getname() + ")\n" + $7->getname(), "statement");
	}
	| IF LPAREN expression RPAREN statement
	{
		outlog << "At line no: " << lines << " statement : IF LPAREN expression RPAREN statement " << std::endl << std::endl;
		outlog << "if(" << $3->getname() << ")\n" << $5->getname() << std::endl << std::endl;
		$$ = new symbol_info("if(" + $3->getname() + ")\n" + $5->getname(), "statement");
	}
	| IF LPAREN expression RPAREN statement ELSE statement
	{
		outlog << "At line no: " << lines << " statement : IF LPAREN expression RPAREN statement ELSE statement " << std::endl << std::endl;
		outlog << "if(" << $3->getname() << ")\n" << $5->getname() << "else\n" << $7->getname() << std::endl << std::endl;
		$$ = new symbol_info("if(" + $3->getname() + ")\n" + $5->getname() + "else\n" + $7->getname(), "statement");
	}
	| WHILE LPAREN expression RPAREN statement
	{
		outlog << "At line no: " << lines << " statement : WHILE LPAREN expression RPAREN statement " << std::endl << std::endl;
		outlog << "while(" << $3->getname() << ")\n" << $5->getname() << std::endl << std::endl;
		$$ = new symbol_info("while(" + $3->getname() + ")\n" + $5->getname(), "statement");
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		outlog << "At line no: " << lines << " statement : PRINTLN LPAREN ID RPAREN SEMICOLON " << std::endl << std::endl;
		outlog << "println(" << $3->getname() << ");" << std::endl << std::endl;
		$$ = new symbol_info("println(" + $3->getname() + ");", "statement");
	}
	| RETURN expression SEMICOLON
	{
		outlog << "At line no: " << lines << " statement : RETURN expression SEMICOLON " << std::endl << std::endl;
		outlog << "return " << $2->getname() << ";" << std::endl << std::endl;
		$$ = new symbol_info("return " + $2->getname() + ";", "statement");
	}
	;

expression_statement : SEMICOLON
	{
		outlog << "At line no: " << lines << " expression_statement : SEMICOLON " << std::endl << std::endl;
		outlog << ";" << std::endl << std::endl;
		$$ = new symbol_info(";", "expr_stmnt");
	}
	| expression SEMICOLON
	{
		outlog << "At line no: " << lines << " expression_statement : expression SEMICOLON " << std::endl << std::endl;
		outlog << $1->getname() + ";" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ";", "expr_stmnt");
	}
	;

expression : logic_expression
	{
		$$ = $1;
	}
	| variable ASSIGNOP logic_expression
	{
		outlog << "At line no: " << lines << " expression : variable ASSIGNOP logic_expression " << std::endl << std::endl;
		outlog << $1->getname() + " = " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " = " + $3->getname(), "expression");
	}
	;

logic_expression : rel_expression
	{
		$$ = $1;
	}
	| rel_expression LOGICOP rel_expression
	{
		outlog << "At line no: " << lines << " logic_expression : rel_expression LOGICOP rel_expression " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() + " " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + " " + $3->getname(), "logic_expression");
	}
	;

rel_expression : simple_expression
	{
		$$ = $1;
	}
	| simple_expression RELOP simple_expression
	{
		outlog << "At line no: " << lines << " rel_expression : simple_expression RELOP simple_expression " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() + " " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + " " + $3->getname(), "rel_expression");
	}
	;

simple_expression : term
	{
		$$ = $1;
	}
	| simple_expression ADDOP term
	{
		outlog << "At line no: " << lines << " simple_expression : simple_expression ADDOP term " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() + " " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + " " + $3->getname(), "simple_expression");
	}
	;

term : unary_expression
	{
		$$ = $1;
	}
	| term MULOP unary_expression
	{
		outlog << "At line no: " << lines << " term : term MULOP unary_expression " << std::endl << std::endl;
		outlog << $1->getname() + " " + $2->getname() + " " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + " " + $2->getname() + " " + $3->getname(), "term");
	}
	;

unary_expression : ADDOP unary_expression
	{
		outlog << "At line no: " << lines << " unary_expression : ADDOP unary_expression " << std::endl << std::endl;
		outlog << $1->getname() + $2->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + $2->getname(), "unary_expression");
	}
	| NOT unary_expression
	{
		outlog << "At line no: " << lines << " unary_expression : NOT unary_expression " << std::endl << std::endl;
		outlog << $1->getname() + $2->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + $2->getname(), "unary_expression");
	}
	| factor
	{
		$$ = $1;
	}
	;

factor : variable
	{
		$$ = $1;
	}
	| ID LPAREN argument_list RPAREN
	{
		outlog << "At line no: " << lines << " factor : ID LPAREN argument_list RPAREN " << std::endl << std::endl;
		outlog << $1->getname() + "(" + $3->getname() + ")" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "(" + $3->getname() + ")", "factor");
	}
	| LPAREN expression RPAREN
	{
		outlog << "At line no: " << lines << " factor : LPAREN expression RPAREN " << std::endl << std::endl;
		outlog << "(" + $2->getname() + ")" << std::endl << std::endl;
		$$ = new symbol_info("(" + $2->getname() + ")", "factor");
	}
	| CONST_INT
	{
		outlog << "At line no: " << lines << " factor : CONST_INT " << std::endl << std::endl;
		outlog << $1->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname(), "factor");
	}
	| CONST_FLOAT
	{
		outlog << "At line no: " << lines << " factor : CONST_FLOAT " << std::endl << std::endl;
		outlog << $1->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname(), "factor");
	}
	| variable INCOP
	{
		outlog << "At line no: " << lines << " factor : variable INCOP " << std::endl << std::endl;
		outlog << $1->getname() + "++" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "++", "factor");
	}
	| variable DECOP
	{
		outlog << "At line no: " << lines << " factor : variable DECOP " << std::endl << std::endl;
		outlog << $1->getname() + "--" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "--", "factor");
	}
	;

argument_list : arguments
	{
		$$ = $1;
	}
	| /* empty */
	{
		outlog << "At line no: " << lines << " argument_list : " << std::endl << std::endl;
		outlog << "()" << std::endl << std::endl;
		$$ = new symbol_info("()", "argument_list");
	}
	;

arguments : arguments COMMA logic_expression
	{
		outlog << "At line no: " << lines << " arguments : arguments COMMA logic_expression " << std::endl << std::endl;
		outlog << $1->getname() + ", " + $3->getname() << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + ", " + $3->getname(), "arguments");
	}
	| logic_expression
	{
		$$ = $1;
	}
	;

variable : ID
	{
		$$ = $1;
	}
	| ID LTHIRD expression RTHIRD
	{
		outlog << "At line no: " << lines << " variable : ID LTHIRD expression RTHIRD " << std::endl << std::endl;
		outlog << $1->getname() + "[" + $3->getname() + "]" << std::endl << std::endl;
		$$ = new symbol_info($1->getname() + "[" + $3->getname() + "]", "variable");
	}
	;

%%

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}

int main(int argc, char* argv[])
{
	if (argc != 2)
	{
		std::cout << "Usage: " << argv[0] << " <symbol_info.h>" << std::endl;
		return 1;
	}
        FILE* file = fopen(argv[1], "r");
        if (!file)
	{
		std::cout << "Error: Couldn't open file " << argv[1] << std::endl;
		return 1;
	}
        yyin = file;
	outlog.open("20101208_log.txt", std::ios::trunc);

	yyparse();

	outlog.close();
	fclose(yyin);
	return 0;
}