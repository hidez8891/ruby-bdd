require "ruby-graphviz"

# BDD形式をグラフとして出力
#
class BDD::Graphviz
  def initialize
    @gv = GraphViz.new(:G, :type => :digraph)
    @nodes = {}
    @index = 0
  end

  # BDD形式をグラフ化
  # 
  def apply (bdd , type='eps')
    @nodes[bdd] ||= @gv.add_nodes(bdd[:name].to_s)

    apply_recursive(bdd)

    @gv.output(type.to_sym => "bdd.#{type}")
  end

  # BDD形式を再帰的にグラフ化
  #
  def apply_recursive (bdd)
    left  = bdd[:true]
    right = bdd[:false]

    [ false, true ].each do |flag|
      node  = bdd[ flag ? :true : :false ]
      name  = node.is_a?(Hash) ? node[:name].to_s : node.to_s
      style = flag ? { :style => "solid" } : { :style => "dotted" }

      unless @nodes.key? node
        @index += 1
        @nodes[node] = @gv.add_nodes(name + "@" + @index.to_s)
        apply_recursive(node) if node.is_a? Hash
      end
      @gv.add_edges(@nodes[bdd], @nodes[node], style)
    end
  end
  private :apply_recursive
end
