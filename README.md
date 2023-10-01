# Thanks Gift

ワンステップで社員にお花を贈るWEBサービス

## 目次

- [Thanks Gift](#thanks-gift)
  - [目次](#目次)
  - [開発環境の構築](#開発環境の構築)
  - [デプロイ手順](#デプロイ手順)
    - [注意事項](#注意事項)
    - [Production環境とStaging環境を`git remote`に設定する](#production環境とstaging環境をgit-remoteに設定する)
    - [Production環境へのデプロイ](#production環境へのデプロイ)
    - [Staging環境へのデプロイ](#staging環境へのデプロイ)
  - [各種タスク](#各種タスク)

## 開発環境の構築
dockerを用いたコンテナ環境になっています。以下の手順に沿って、環境を構築してください。
```
docker compose build
docker compose up -d
docker compose exec rails db:create
docker compose exec rails db:migrate
docker compose exec rails db:seed
```

## デプロイ手順
### 注意事項
※ Production環境、Staging環境のいづれにおいても、Herokuのアクセス権限を保持していることを前提としています。アクセス権限を保持していない場合は、管理者より権限を付与していただいてください。

※ Herokuのアクセス権限は、[こちら](https://dashboard.heroku.com/teams/onestepgift/access)より確認できます。

### Production環境とStaging環境を`git remote`に設定する
`git clone`時のremote情報 (`git remote -v`で確認すると以下のようになっていると思います)
```
origin https://github.com/NODASHUSEINANODA/ohana_api.git (fetch)
origin https://github.com/NODASHUSEINANODA/ohana_api.git (push)
```

Production環境とStaging環境を`git remote`に設定
```
git remote add staging https://git.heroku.com/thanks-gift-stg.git
git remote add production https://git.heroku.com/thanks-gift.git
```

`git remote -v`で以下の結果になれば完了
```
origin https://github.com/NODASHUSEINANODA/ohana_api.git (fetch)
origin https://github.com/NODASHUSEINANODA/ohana_api.git (push)
production https://git.heroku.com/thanks-gift.git (fetch)
production https://git.heroku.com/thanks-gift.git (push)
staging https://git.heroku.com/thanks-gift-stg.git (fetch)
staging https://git.heroku.com/thanks-gift-stg.git (push)
```

### Production環境へのデプロイ
```
git push production main
```

### Staging環境へのデプロイ
※ Staging環境にはstagingブランチを対応させるようにしてください。
```
git push staging staging:main
```

デバッグのためにStaging環境に他のブランチをデプロイしたい際は `git push production (ブランチ名):main` でデプロイできます。
## 各種タスク
何らかの原因で、バッチ処理が動いていない場合は、コンソールから以下のコマンドを実行できます。
※ 全ての会社分、実行されるので注意してください。

- 会社代表者へのリマインドメール
```
rails runner Tasks::SendMail::ToPresident.exec
```

- 花屋への注文
```
rails runner Tasks::Order.exec
```
