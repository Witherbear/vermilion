{
module Parser where

import Lexer
import Control.Monad (void)
}

%name parseExpr
%token
    TOpenParen      { TOpenParen }
    TCloseParen     { TCloseParen }
    TOpenBracket    { TOpenBracket }
    TCloseBracket   { TCloseBracket }
    TComma          { TComma }
    TEquals         { TEquals }
    TColon          { TColon }
    TSemicolon      { TSemicolon }
    TIdentifier     { String }
    TInteger        { Int }
    TString         { String }
    TEnd            { TEnd }

%start program
%type <[Expr]> program

%%
program : exprs TEnd { $1 }

exprs   : exprs expr      { $1 ++ [$2] }
        | expr            { [$1] }

expr    : statement
        | function

statement : TIdentifier TEquals expr           { Assign $1 $3 }
          | TIdentifier TColon type TEquals expr  { TypedAssign $1 $3 $5 }
          | TIdentifier                           { Var $1 }
          | TIdentifier TOpenBracket expr TCloseBracket { Index $1 $3 }
          | TIdentifier TOpenParen args TCloseParen      { Call $1 $3 }
          | TOpenParen expr TCloseParen                   { Paren $2 }
          | TString                                       { StringLit $1 }
          | TInteger                                      { IntLit $1 }
          | TIdentifier                                   { VarRef $1 }
          | if_statement
          | while_statement
          | for_statement
          | loop_statement

type : TIdentifier

args : exprs
     | /* empty */

function : TIdentifier TOpenParen TCloseParen block { Function $1 [] $4 }
          | TIdentifier TOpenParen args TCloseParen block { Function $1 $3 $5 }

block   : TOpenBracket exprs TCloseBracket { $2 }

if_statement : TIdentifier TEquals expr TColon block elseif_statements else_statement { If $3 $5 $6 $7 }

elseif_statements : elseif_statements elseif_statement { $1 ++ [$2] }
                   | /* empty */

elseif_statement : TIdentifier TEquals expr TColon block { ElseIf $3 $5 }

else_statement : TIdentifier TColon TOpenBracket exprs TCloseBracket { Else $4 }

while_statement : TIdentifier TEquals expr TColon block { While $3 $5 }

for_statement : TIdentifier TEquals expr TSemicolon expr TSemicolon expr TColon block { For $3 $5 $7 $9 }

loop_statement : TIdentifier TColon block { Loop $3 }
