## BDD (Binary Decision Diagram)

BDDを作成してみる、それだけのライブラリ

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

## License

[MIT License](http://www.opensource.org/licenses/MIT)
