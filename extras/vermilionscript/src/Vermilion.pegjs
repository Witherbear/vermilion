start = class_declaration

class_declaration = "class" identifier ":" method_declaration+

method_declaration = "fun" identifier "(" ")" ":" statement+

statement = call | assignment | comment | print

call = identifier "." identifier "(" args ")"

assignment = identifier "=" expression

comment = "#" comment_text

print = "print" "(" args ")"

args = (identifier ("," identifier)*)?

expression = string_literal | number_literal | call

string_literal = "\"" char* "\""

number_literal = digit+

comment_text = (!"\n" .)*

identifier = letter (letter / digit / "_")*

char = letter / digit / " "

letter = [a-zA-Z]

digit = [0-9]
