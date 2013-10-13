
# BDD形式の述語を保持する
#
class BDD
  def initialize
    @bdd_hash = nil
  end

  # 述語を読み込む
  #
  def load (predicate)
    predicate = predicate.gsub(' ', '')
    parse_result = BDD::Parser.new().parse(predicate)
    @bdd_hash    = BDD::Transform.new().apply(parse_result)
  end

  # BDD形式のハッシュを取得
  #
  def to_hash
    @bdd_hash
  end

  # グラフ出力
  #
  def to_graph (format = 'eps')
    BDD::Graphviz.new().apply(@bdd_hash, format) if @bdd_hash
  end
end

require 'bdd/factory'
require 'bdd/parser'
require 'bdd/transform'
require 'bdd/graphviz'
