# Thanks Gift

ワンステップで社員にお花を贈るWEBサービス

## 目次

- [Thanks Gift](#thanks-gift)
  - [目次](#目次)
  - [開発環境の構築](#開発環境の構築)
  - [ログイン](#ログイン方法)
  - [デプロイ手順](#デプロイ手順)
    - [注意事項](#注意事項)
    - [Production環境とStaging環境を`git remote`に設定する](#production環境とstaging環境をgit-remoteに設定する)
    - [migrationに変更がある場合](#migrationに変更がある場合)
      - [ローカルからDBのみリモートに接続する](#ローカルからdbのみリモートに接続する)
      - [リモートのDBを更新](#リモートのdbを更新)
    - [Production環境へのデプロイ](#production環境へのデプロイ)
    - [Staging環境へのデプロイ](#staging環境へのデプロイ)
  - [各種タスク](#各種タスク)

## 開発環境の構築
dockerを用いたコンテナ環境になっています。以下の手順に沿って、環境を構築してください。
```shell
docker compose build
docker compose up -d
docker compose exec rails db:create
docker compose exec rails db:migrate
docker compose exec rails db:seed
```
## ログイン方法
- production環境のログインは基本的に想定していません
  - どうしてもログインが必要な際は、管理者に相談し、本番環境のDBを参照してください
- staging環境のログインは以下のメールとパスワードでログインできます。(rails db:seedで初期データを作成している前提です)
  ```
  # 会社1　
  メール : test1@example.com
  パスワード : password

  # 会社2
  メール : test2@example.com
  パスワード : password

  # 会社3
  メール : test3@example.com
  パスワード : password
  ```
  - staging環境では、会社の登録は画面上からはできないため上記のいずれかの会社でログインしてください
  - 万が一、ログインできなくなった場合は以下のコマンドでデータを初期化します。（全てのデータが初期化されるので十分に注意してください）
  ```
  rails db:migrate:reset
  rails db:seed
  ```
## デプロイ手順
### 注意事項
※ Production環境、Staging環境のいづれにおいても、Herokuのアクセス権限を保持していることを前提としています。アクセス権限を保持していない場合は、管理者より権限を付与していただいてください。

※ Herokuのアクセス権限は、[こちら](https://dashboard.heroku.com/teams/onestepgift/access)より確認できます。

### Production環境とStaging環境を`git remote`に設定する
`git clone`時のremote情報 (`git remote -v`で確認すると以下のようになっていると思います)
```shell
origin https://github.com/NODASHUSEINANODA/ohana_api.git (fetch)
origin https://github.com/NODASHUSEINANODA/ohana_api.git (push)
```

Production環境とStaging環境を`git remote`に設定
```shell
git remote add staging https://git.heroku.com/thanks-gift-stg.git
git remote add production https://git.heroku.com/thanks-gift.git
```

`git remote -v`で以下の結果になれば完了
```shell
origin https://github.com/NODASHUSEINANODA/ohana_api.git (fetch)
origin https://github.com/NODASHUSEINANODA/ohana_api.git (push)
production https://git.heroku.com/thanks-gift.git (fetch)
production https://git.heroku.com/thanks-gift.git (push)
staging https://git.heroku.com/thanks-gift-stg.git (fetch)
staging https://git.heroku.com/thanks-gift-stg.git (push)
```

### migrationに変更がある場合
migrationの変更がある場合、下のデプロイコマンドのみだとmigrateがされていないとエラーになる。
なので、先にリモート(本番 or ステージング) のDBのテーブルを更新する必要がある。

#### ローカルからDBのみリモートに接続する
以下のコマンドをHerokuから対応する環境変数を取得して実行
```shell
docker compose run -e RAILS_ENV=staging or production APP_DATABASE=hoge -e APP_DATABASE_HOST=hoge -e APP_DATABASE_PASSWORD=hoge -e APP_DATABASE_USERNAME=hoge -e ONAMAE_MAIL_SMTP_ADDRESS=hoge -e ONAMAE_MAIL_SMTP_DOMAIN=hoge -e ONAMAE_MAIL_SMTP_PASSWORD=hoge -e ONAMAE_MAIL_SMTP_PORT=hoge -e SECRET_KEY_BASE=hoge web /bin/bash
```

各環境で設定されている環境変数を取得するには以下のコマンドを実行

```shell
# Production環境の環境変数
heroku config -a thanks-gift

# or

# STG環境の環境変数
heroku config -a thanks-gift-stg
```

#### リモートのDBを更新
```shell
# migrateの状態を確認
rails db:migrate:status

# 問題なければ
rails db:migrate
```

### Production環境へのデプロイ
```shell
git push production main
```

### Staging環境へのデプロイ
※ Staging環境にはstagingブランチを対応させるようにしてください。
```shell
git push staging staging:main
```

デバッグのためにStaging環境に他のブランチをデプロイしたい際は `git push production (ブランチ名):main` でデプロイできます。
## 各種タスク
何らかの原因で、バッチ処理が動いていない場合は、コンソールから以下のコマンドを実行できます。
※ 全ての会社分、実行されるので注意してください。

- 会社代表者へのリマインドメール
```shell
rails runner Tasks::SendMail::ToPresident.exec
```

- 花屋への注文
```shell
rails runner Tasks::Order.exec
```
