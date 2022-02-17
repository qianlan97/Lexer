/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2000 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%%

%class Lexer
%byaccj
%line
%column

%{

  public Parser   parser;
  public int      lineno;
  public int      column;

  public Lexer(java.io.Reader r, Parser parser) {
    this(r);
    this.parser = parser;
    this.lineno = 1;
    this.column = 1;
  }
%}

bool        = [true|false]
int         = [0-9]+
float       = [0-9]+"."[0-9]*(E[+-]?[0-9]+)?
identifier  = [a-zA-Z][a-zA-Z0-9_]*
newline     = \n
whitespace  = [ \t\r]+
linecomment = "//".*

%%
//                                                                  attribution               token name
"print"                             { parser.yylval = new ParserVal(null            ); return Parser.PRINT   ; }
"func"                              { parser.yylval = new ParserVal(null            ); return Parser.FUNC    ; }
"void"                              { parser.yylval = new ParserVal(null            ); return Parser.VOID    ; }
"bool"                              { parser.yylval = new ParserVal(null            ); return Parser.BOOL    ; }
"int"                               { parser.yylval = new ParserVal(null            ); return Parser.INT     ; }
"float"
"struct"
"size"
"new"
"if"
"then"
"else"
"begin"                             { parser.yylval = new ParserVal(null            ); return Parser.BEGIN   ; }
"end"                               { parser.yylval = new ParserVal(null            ); return Parser.END     ; }
"while"
"return"
"break"
"continue"
"("                                 { parser.yylval = new ParserVal(null            ); return Parser.LPAREN  ; }
")"                                 { parser.yylval = new ParserVal(null            ); return Parser.RPAREN  ; }
"["
"]"
";"                                 { parser.yylval = new ParserVal(null            ); return Parser.SEMI    ; }
","
"."
"&"
"::"                                { parser.yylval = new ParserVal(null            ); return Parser.TYPEOF  ; }
"<-"                                { parser.yylval = new ParserVal(null            ); return Parser.ASSIGN  ; }
"->"                                { parser.yylval = new ParserVal(null            ); return Parser.FUNCRET ; }
"+"                                 { parser.yylval = new ParserVal(null            ); return Parser.OP      ; }
"-"
"*"
"/"
"and"
"or"
"not"
"="
"!="
"<"                                 { parser.yylval = new ParserVal(null            ); return Parser.RELOP   ; }
">"
"<="
">="
{bool}
{int}                               { parser.yylval = new ParserVal((Object)yytext()); return Parser.INT_VALUE ; }
{float}                             { parser.yylval = new ParserVal((Object)yytext()); return Parser.FLOAT_VALUE ; }
{identifier}                        { parser.yylval = new ParserVal((Object)yytext()); return Parser.IDENT   ; }
{linecomment}                       { System.out.println("line comment: \""   +yytext()+"\""); /* skip */ }
{newline}                           { System.out.print("\n"                          ); /* skip */ }
{whitespace}                        { System.out.print(yytext());                       /* skip */ }
"<!--"(.|\n)*"-->"                  { System.out.println("block comment begin\""            );
                                      System.out.println(yytext()                           );
                                      System.out.println("block comment end+\""             ); /* skip */ }


\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
