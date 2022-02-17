import java.util.Iterator;
import java.util.HashMap;


public class Parser
{
    public static final int PRINT       = 10; // "print"
    public static final int FUNC        = 11; // "func"
    public static final int VAR         = 12; // "var"
    public static final int VOID        = 13; // "void"
    public static final int BOOL        = 14; // "bool"
    public static final int INT         = 15; // "int"
    public static final int FLOAT       = 16; // "float"
    public static final int STRUCT      = 17; // "struct"
    public static final int SIZE        = 18; // "size"
    public static final int NEW         = 19; // "new"
    public static final int IF          = 20; // "if"
    public static final int THEN        = 21; // "then"
    public static final int ELSE        = 22; // "else"
    public static final int BEGIN       = 23; // "begin"
    public static final int END         = 24; // "end"
    public static final int WHILE       = 25; // "while"
    public static final int RETURN      = 26; // "return"
    public static final int BREAK       = 27; // "break"
    public static final int CONTINUE    = 28; // "continue"
    public static final int LPAREN      = 29; // "("
    public static final int RPAREN      = 30; // ")"
    public static final int LBRACKET    = 31; // "["
    public static final int RBRACKET    = 32; // "]"
    public static final int SEMI        = 33; // ";"
    public static final int COMMA       = 34; // ","
    public static final int DOT         = 35; // "."
    public static final int ADDR        = 36; // "&"
    public static final int TYPEOF      = 37; // "::"
    public static final int ASSIGN      = 38; // "<-"
    public static final int FUNCRET     = 39; // "->"
    public static final int OP          = 40; // "+", "-", "*", "/", "and", "or", "not"
    public static final int RELOP       = 41; // "=", "!=", "<", ">", "<=", ">="
    public static final int BOOL_VALUE    = 42; // "true", "false"
    public static final int INT_VALUE     = 43; //
    public static final int FLOAT_VALUE   = 44; //
    public static final int IDENT       = 45; // 

    public String type(int i) {
        switch (i) {
            case 10: return "PRINT";
            case 11: return "FUNC";
            case 12: return "VAR";
            case 13: return "VOID";
            case 14: return "BOOL";
            case 15: return "INT";
            case 16: return "FLOAT";
            case 17: return "STRUCT";
            case 18: return "SIZE";
            case 19: return "NEW";
            case 20: return "IF";
            case 21: return "THEN";
            case 22: return "ELSE";
            case 23: return "BEGIN";
            case 24: return "END";
            case 25: return "WHILE";
            case 26: return "RETURN";
            case 27: return "BREAK";
            case 28: return "CONTINUE";
            case 29: return "LPAREN";
            case 30: return "RPAREN";
            case 31: return "LBRACKET";
            case 32: return "RBRACKET";
            case 33: return "SEMI";
            case 34: return "COMMA";
            case 35: return "DOT";
            case 36: return "ADDR";
            case 37: return "TYPEOF";
            case 38: return "ASSIGN";
            case 39: return "FUNCRET";
            case 40: return "OP";
            case 41: return "RELOP";
            case 42: return "BOOL_VALUE";
            case 43: return "INT_VALUE";
            case 44: return "FLOAT_VALUE";
            case 45: return "IDENT";
            default: return "error";
        }
    }

    HashMap<String, Integer> ID = new HashMap<String, Integer>();
    int i = 0;

    public Parser(java.io.Reader r) throws java.io.IOException
    {
        this.lexer    = new Lexer(r, this);
    }

    Lexer   lexer;
    public ParserVal yylval;

    public int yyparse() throws java.io.IOException
    {
        while ( true )
        {
            int token = lexer.yylex();
            if(token == 0)
            {
                // EOF is reached
                return 0;
            }
            if(token == -1)
            {
                // error
                return -1;
            }

            Object attr = yylval.obj;
            String tokenName = type(token);

            if (attr == null) {
                System.out.print("<" + tokenName + " :" + (lexer.yyline+1) + ":" + (lexer.yycolumn+1) + ">");
            }
            else if (tokenName == "IDENT"){
                if (ID.get(attr.toString()) != null){
                    System.out.print("<ID, " + ID.get(attr) + " :" + (lexer.yyline+1) + ":" + (lexer.yycolumn+1) + ">");
                }
                else{
                    ID.put(attr.toString(),i);
                    i++;
                    System.out.print("<<symbol table entity [" + ID.get(attr) + ", \"" + attr + "\"]>><ID, " + ID.get(attr.toString()) + " :" + (lexer.yyline+1) + ":" + (lexer.yycolumn+1) + ">");
                }
            }
            else {
                System.out.print("<" + tokenName + ", " + attr +  " :" + (lexer.yyline+1) + ":" + (lexer.yycolumn+1) + ">");
            }
        }
    }
}
