---
title: "Markdown Sample"
date: 2021-03-30T22:15:15+09:00
---


# Hugoによるmarkdownからhtmlへの変換の試験

### はじめに


段落は空白の行ごとに区切られる。

*斜体*, **太字**, そして `行内でのコード`。


### 見出し 

# h1

## h2

### h3

#### h4

##### h5

###### h6

### 複数行の引用

複数行に渡って背景たるdivを適用する。


> blockquote
> 引用2


### リスト

配列は、かの如く:

- ひとつめ
- ふたつめ
- みっつめ

又は、

- a
- b
  - b1 on b
  - b1 on b
- f
- g

更に、

+ あ
+ い
+ う


数値付きの配列

1. 1です
2. 2です
5. 3です
0. 4です
8. 5です. 入れ子にもできます



### 水平線

水平線 `<br />`

---
 
***

### リンク

[google](https://www.google.com) とか、
[yahoo](https://www.google.com) とか。

画像です。



![山](https://www.photock.jp/photo/middle/photo0000-0705.jpg)

### エスケープ

地の文で表現に用いた文字が、markdown言語の構文の文字として解釈されることで、望まれない文書の構造の崩壊が発生しうるが、
これを防ぐ為に、地の文を記述する際にエスケープ文字を衝突しうる文字に付与する。

\\ \` \* \_ \{ \} \[ \] \( \) \# \+ \- \. \!





### ソースコード

```
すぱげってぃ
ぱげすってぃ
すげぱってぃ
っげぱすてぃ
てげぱすっぃ
```

```haskell
functor :: forall m a b c.
           ( Functor m
           , Arbitrary b, Arbitrary c
           , CoArbitrary a, CoArbitrary b
           , Show (m a), Arbitrary (m a), EqProp (m a), EqProp (m c)) =>
           m (a,b,c) -> TestBatch
functor = const ( "functor"
                , [ ("identity", property identityP)
                , ("compose" , property composeP) ]
                )
 where
   identityP :: Property
   composeP  :: (b -> c) -> (a -> b) -> Property

   identityP = fmap id =-= (id :: m a -> m a)
   composeP g f = fmap g . fmap f =-= (fmap (g.f) :: m a -> m c)
```

### 数式

MathJaxを用いた。

$x$に関する二次方程式は $ax^2+bx^2+c=0$ に一般化され、解くと、
$$x = \frac{-b\pm\sqrt{b^2-4ac}}{2a} $$となる。

