{
module Lexer where

import Data.Char

type AlexInput = String

data Token = TOpenParen | TCloseParen | TOpenBracket | TCloseBracket | TComma | TEquals | TColon | TSemicolon | TIdentifier String | TInteger Int | TString String | TEnd
    deriving (Eq, Show)
}

tokens :- {
    "(":        TOpenParen
    ")":        TCloseParen
    "[":        TOpenBracket
    "]":        TCloseBracket
    ",":        TComma
    "=":        TEquals
    ":":        TColon
    ";":        TSemicolon
    ['a'-'z']+  TIdentifier $$
    ['A'-'Z'] ['a'-'z']* TIdentifier $$
    ['-']? ['0'-'9']+ TInteger $$
    ['"']([^'"']*['"']?)['"'] TString $$
    [_]*[ \t\n\r] AlexMonad.skip
}

main :: IO ()
main = do
    input <- getContents
    let tokens = alexScanTokens input
    mapM_ print tokens
