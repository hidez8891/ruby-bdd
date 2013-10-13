require 'parslet'
require 'bdd/factory'

# 述語をBDD形式に変換
# 
# @api private
class BDD::Transform < Parslet::Transform
  rule(:literal => simple(:x)){
    BDD::Factory.variable(x.to_s)
  }

  rule(:left => subtree(:l)){
    l
  }

  rule(:left => subtree(:l), :op => simple(:op), :right => subtree(:r)){
    BDD::Factory.composition(op.to_s, l, r)
  }
end
