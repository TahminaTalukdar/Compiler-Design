%option noyywrap

%{

#include<bits/stdc++.h>
using namespace std;

ofstream yyoutlog; //output filestream for log file

string loglist = ""; //list of tokens along with line numbers

// define necessary c++ variables and functions here (if any)
int lines=1; //to keep track of line numbers

%}

/* Regular Definitions */

delim [ \t\n]

/* write regular expressions for whitespace and newline */
ws [ \t]+

newline \n

letter [a-zA-Z]
digit [0-9]

/* write regular expressions for id, float and integers */

id [a-zA-Z_][a-zA-Z0-9_]*
float [0-9]*"."[0-9]+
integer [0-9]+
%%

{ws} { /* ignore whitespace */ }

{newline} {
		lines++;
        /* do necessary bookkeeping (line number tracking etc.) */
    }

{id} {
            loglist="Line no "+to_string(lines)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
            yyoutlog<<loglist;
        }
{integer} {
            loglist="Line no "+to_string(lines)+": Token <CONST_INT> Lexeme "+yytext+" found"+"\n"+"\n";
            yyoutlog<<loglist;
        }

{float} {
            loglist="Line no "+to_string(lines)+": Token <CONST_FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
            yyoutlog<<loglist;
        }

{ws}if{ws} {
			loglist="Line no "+to_string(lines)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
			yyoutlog<<loglist;
		}

{ws}range{ws} {
            loglist="Line no "+to_string(lines)+": Token <RANGE> Lexeme "+yytext+" found"+"\n"+"\n";
            yyoutlog<<loglist;
        }

{ws}"+"|"-"{ws} { /* to match two same operators use | */
			loglist="Line no "+to_string(lines)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
			yyoutlog<<loglist;
		}

{ws}else{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <ELSE> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}except{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <EXCEPT> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}or{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <OR> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}for{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <FOR> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}


{ws}in{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <IN> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}break{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <BREAK> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}def{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <DEF> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}continue{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <CONTINUE> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}not{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <NOT> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}return{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <RETURN> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}pass{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <PASS> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}"++"|"--"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <INCOP> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}"<"|">"|"=="{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <RELOP> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}"="{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <ASSIGNOP> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}

{ws}"&&"|"||"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <LOGICOP> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"!"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <NOT> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"("{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <LPAREN> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}")"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <RPAREN> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"{"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <LCURL> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"}"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <RCURL> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"["{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <LTHIRD> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}"]"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <RTHIRD> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}","{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <COMMA> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}
{ws}":"{ws} {
    loglist = "Line no " + to_string(lines) + ": Token <COLON> Lexeme " + yytext + " found" + "\n" + "\n";
    yyoutlog << loglist;
}


%%

int main(int argc, char *argv[])
{

	if(argc != 2) //check if file name is given
	{
        cout<<"Please input file name"<<endl;
		return 0;
	}

	yyin = fopen(argv[1], "r"); //the file to be read must be assigned to yyin

	yyoutlog.open("my_log.txt", ios::trunc); // remember to rename the log file as mentioned in the spec
	
	if(yyin == NULL) // file does not exist
	{
		cout<<"Wrong File Name"<<endl;
	}
	
	yylex(); // start reading the input file in a loop
	
	yyoutlog<<"Total lines: " + to_string(lines);

	yyoutlog.close(); // close the log file
	
	fclose(yyin); // close the input file
}