require 'parslet'

# 述語の構文解析を実施
#
# Syntax:
# 
#   equation ::= factor ('+' factor)*
#   factor   ::= term   ('*' term)*
#   term     ::= '(' equation ')' | literal
#   literal  ::= text (text | number)*
#   text     ::= [a..zA..Z]
#   number   ::= [0..9]
#
# @api private
class BDD::Parser < Parslet::Parser
  root(:equation)

  rule(:equation) {
    factor.as(:left) >> ( str('+').as(:op) >> equation.as(:right) ).maybe
  }

  rule(:factor) {
    term.as(:left) >> ( str('*').as(:op) >> factor.as(:right) ).maybe
  }

  rule(:term) {
    ( str('(') >> equation.as(:equation) >> str(')') ) | literal.as(:literal)
  }

  rule(:literal) {
    match('[a-z]') >> ( match('[a-z]') | match('[0-9]') ).repeat(0)
  }
end
