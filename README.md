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
## Herokuで常駐化

Procfileを用意し、起動時に実行するスクリプトを書いておく。

Procfile
```
bot: bundle exec ruby rtm.rb
```

Herokuにログインしたら、Ruby実行環境用にビルドパックを追加してアプリケーションを作成する。
```
$ heroku login
$ heroku create --buildpack https://github.com/heroku/heroku-buildpack-ruby.git
```

Herokuにデプロイ、環境変数の設定を行う。  
Gemfile.lockがないとビルドに失敗する。
```
$ git push heroku master
$ heroku config:set SLACK_API_TOKEN=<トークン>
```

ボット起動。
```
$ heroku ps:scale bot=1
```

停止する時は以下のコマンドを実行。psコマンドでプロセスを確認しておくこと。
```
$ heroku ps:scale bot=0
$ heroku ps
```




