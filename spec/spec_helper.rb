$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bdd'

RSpec.configure do |config|
end

def make_node (name, tval, fval)
  { name: name, true: tval , false: fval }
end

def make_var (name)
  make_node(name, 1, 0)
end

def make_or (name, var)
  var = make_var(var) unless var.is_a? Hash
  make_node(name, 1, var)
end

def make_and (name, var)
  var = make_var(var) unless var.is_a? Hash
  make_node(name, var, 0)
end
