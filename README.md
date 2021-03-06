## BDD (Binary Decision Diagram)

[![Build Status](https://travis-ci.org/hidez8891/ruby-bdd.png)](https://travis-ci.org/hidez8891/ruby-bdd)

BDDを作成してみる、それだけのライブラリ

* 述語の文字列からBDDを作成
* 簡単な簡約化を実施
* BDDを画像として出力可能

## Example

1. 文字列から述語を読みます

        bdd = BDD.new()
        bdd.load("x1+x2")

2. ハッシュで受け取れます

        # {
        #   name:  'x1' ,
        #   true:   1   ,
        #   false: {
        #     name: 'x2',
        #     true:  1  ,
        #     false: 0
        #   }
        # }
        bdd.to_hash

3. 画像出力ができます (要: Graphviz)

        # eps形式で出力
        # output: bdd.eps
        bdd.to_graph
        
        # png形式で出力
        # output: bdd.png
        bdd.to_graph('png')

## TODO

 * 否定演算に未対応
 * 恒真/矛盾の表現手段が無い

## License

[MIT License](http://www.opensource.org/licenses/MIT)
