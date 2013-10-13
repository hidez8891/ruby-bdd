
# BDD用の変数/ノード生成
#
# @api private
module BDD::Factory

  # BDDノードの合成
  # 
  def composition (ope, nodeL, nodeR)
    if nodeL == nodeR
      nodeL
    else
      var   = [nodeL[:name], nodeR[:name]].min
      index = [ope, nodeL, nodeR]

      unless @@nodes.key? index
        fnode = composition_recursive(ope, var, nodeL, nodeR, false)
        tnode = composition_recursive(ope, var, nodeL, nodeR, true)

        # removed
        tnode = tnode[:true] if tnode.is_a? Hash and tnode[:false] == tnode[:true]
        fnode = fnode[:true] if fnode.is_a? Hash and fnode[:false] == fnode[:true]

        @@nodes[index] = {:name => var, :false => fnode, :true => tnode}
      end

      @@nodes[index]
    end
  end
  module_function :composition

  # BDDノードの合成 (再帰的に)
  # 
  def composition_recursive (ope, var, nodeL, nodeR, node_status)
    next_nodeL, next_nodeR = [nodeL, nodeR].map do |node|
      (node[:name] == var) ? node[node_status.to_s.to_sym] : node
    end

    both   = (ope == "+") ? 0 : 1
    either = (ope == "+") ? 1 : 0
    
    return either if next_nodeL == either or  next_nodeR == either
    return both   if next_nodeL == both   and next_nodeR == both
    return next_nodeL if next_nodeR == both
    return next_nodeR if next_nodeL == both

    composition(ope, next_nodeL, next_nodeR)
  end
  private :composition_recursive
  module_function :composition_recursive
  private_class_method :composition_recursive

  # BDD用変数の取得
  #
  def variable (var)
    @@nodes ||= {}
    @@nodes[var.to_s] ||= {:name => var, :false => 0, :true => 1}
  end
  module_function :variable
end
