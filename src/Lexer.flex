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

int         = [0-9]+
float       = [0-9]+"."[0-9]*(E[+-]?[0-9]+)?
identifier  = [a-zA-Z][a-zA-Z0-9_]*
newline     = \n
whitespace  = [ \t\r]+
linecomment = "//".*

%%
//                                                                  attribution               token name
"print"                             { parser.yylval = new ParserVal(null            ); return Parser.PRINT        ; }
"func"                              { parser.yylval = new ParserVal(null            ); return Parser.FUNC         ; }
"void"                              { parser.yylval = new ParserVal(null            ); return Parser.VOID         ; }
"bool"                              { parser.yylval = new ParserVal(null            ); return Parser.BOOL         ; }
"int"                               { parser.yylval = new ParserVal(null            ); return Parser.INT          ; }
"float"                             { parser.yylval = new ParserVal(null            ); return Parser.FLOAT        ; }
"struct"                            { parser.yylval = new ParserVal(null            ); return Parser.STRUCT       ; }
"size"                              { parser.yylval = new ParserVal(null            ); return Parser.SIZE         ; }
"new"                               { parser.yylval = new ParserVal(null            ); return Parser.NEW          ; }
"if"                                { parser.yylval = new ParserVal(null            ); return Parser.IF           ; }
"then"                              { parser.yylval = new ParserVal(null            ); return Parser.THEN         ; }
"else"                              { parser.yylval = new ParserVal(null            ); return Parser.ELSE         ; }
"begin"                             { parser.yylval = new ParserVal(null            ); return Parser.BEGIN        ; }
"end"                               { parser.yylval = new ParserVal(null            ); return Parser.END          ; }
"while"                             { parser.yylval = new ParserVal(null            ); return Parser.WHILE        ; }
"return"                            { parser.yylval = new ParserVal(null            ); return Parser.RETURN       ; }
"break"                             { parser.yylval = new ParserVal(null            ); return Parser.BREAK        ; }
"continue"                          { parser.yylval = new ParserVal(null            ); return Parser.CONTINUE     ; }
"("                                 { parser.yylval = new ParserVal(null            ); return Parser.LPAREN       ; }
")"                                 { parser.yylval = new ParserVal(null            ); return Parser.RPAREN       ; }
"["                                 { parser.yylval = new ParserVal(null            ); return Parser.LBRACKET     ; }
"]"                                 { parser.yylval = new ParserVal(null            ); return Parser.RBRACKET     ; }
";"                                 { parser.yylval = new ParserVal(null            ); return Parser.SEMI         ; }
","                                 { parser.yylval = new ParserVal(null            ); return Parser.COMMA        ; }
"."                                 { parser.yylval = new ParserVal(null            ); return Parser.DOT          ; }
"&"                                 { parser.yylval = new ParserVal(null            ); return Parser.ADDR         ; }
"::"                                { parser.yylval = new ParserVal(null            ); return Parser.TYPEOF       ; }
"<-"                                { parser.yylval = new ParserVal(null            ); return Parser.ASSIGN       ; }
"->"                                { parser.yylval = new ParserVal(null            ); return Parser.FUNCRET      ; }
"+"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"-"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"*"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"/"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"and"                               { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"or"                                { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"not"                               { parser.yylval = new ParserVal((Object)yytext()); return Parser.OP           ; }
"="                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
"!="                                { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
"<"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
">"                                 { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
"<="                                { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
">="                                { parser.yylval = new ParserVal((Object)yytext()); return Parser.RELOP        ; }
"true"                              { parser.yylval = new ParserVal((Object)yytext()); return Parser.BOOL_VALUE   ; }
"false"                             { parser.yylval = new ParserVal((Object)yytext()); return Parser.BOOL_VALUE   ; }
{int}                               { parser.yylval = new ParserVal((Object)yytext()); return Parser.INT_VALUE    ; }
{float}                             { parser.yylval = new ParserVal((Object)yytext()); return Parser.FLOAT_VALUE  ; }
{identifier}                        { parser.yylval = new ParserVal((Object)yytext()); return Parser.IDENT        ; }
{linecomment}                       { System.out.print(yytext());                                        /* skip */ }
{newline}                           { System.out.print(yytext());                                        /* skip */ }
{whitespace}                        { System.out.print(yytext());                                        /* skip */ }
"<!--"(.|\n)*"-->"                  { System.out.print(yytext());                                                   }


\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
