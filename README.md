# slack bot

## Ruby環境構築

rbenvでRubyのバージョン管理。
```
$ rbenv versions
$ rbenv install 2.6.3
$ rbenv global 2.6.3
$ rbenv rehash
$ ruby -v
```

## Botアプリケーションの動作テスト

Gemfileを書いて、以下を実行。
```
$ bundle install --path vendor/bundle
```

スクリプトを実行してAPI動作確認。
```
$ bundle exec ruby test.rb
```

SlackのAppsよりBotsアプリケーションを設定し、トークンを取得。取得したトークンは環境変数へ設定しておく。
```
$ export SLACK_API_TOKEN=<トークン>
$ bundle exec ruby auth.rb
```

`#dev`チャンネルを作成して、botからpost。
```
$ bundle exec ruby post.rb
```