# lesson-rpg-ruby
Rubyのレッスン用コード

### 概要
簡易RPG。
勇者と魔物がHP無くなるまで殴り合う。
勇者はアイテムを装備できるが、魔物は何も装備できない。
しかし、魔物の王である魔王は魔法を使うことが出来る。

### 目的
- rubyの書き方に慣れる
- requireの意味を知る
- オブジェクト指向って何かを知る
    - 継承とメソッドオーバライド(多態性)
    - カプセル化

## Docker による起動まで
### imageの作成(初回、Dockerfileを変えたときだけ)
```
docker build ./ -t ruby_nvm
```
### 起動
```
docker run -v `pwd`:/app -it ruby_nvm /bin/bash
```
