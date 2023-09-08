# ONE-STEP-GIFT

ワンステップで社員にお花を贈るWEBサービス

## 目次

- [ONE-STEP-GIFT](#one-step-gift)
  - [目次](#目次)
  - [開発環境の構築](#開発環境の構築)
  - [機能](#機能)
    - [ログイン](#ログイン)
    - [花屋への定期注文](#花屋への定期注文)
    - [次回の注文内容の編集](#次回の注文内容の編集)
    - [会社代表者へのリマインド](#会社代表者へのリマインド)
    - [社員情報の閲覧、追加、編集、削除、検索](#社員情報の閲覧追加編集削除検索)
  - [各種タスク](#各種タスク)
  - [各種リンク](#各種リンク)

## 開発環境の構築
dockerを用いたコンテナ環境になっています。以下の手順に沿って、環境を構築してください。
```
docker compose build
docker compose up -d
docker compose exec rails db:create
docker compose exec rails db:migrate
docker compose exec rails db:seed
```

## 機能
### ログイン
- 本システムは会社単位でのログインになります。
- 同じ会社の方は、同じメール、同じパスワードを共有して利用してください。
### 花屋への定期注文
  - 毎月15日に花屋へ注文内容記載したメールを送信します。(注文内容がない場合は、その旨を記載したメールを送信)
### 次回の注文内容の編集
- 編集できる項目は、①送り先、②メニュー、③送るか送らないか、の3つになります。
  - ① 住所を登録している社員には、会社か自宅のどちらに送るかを設定できるようになります。住所が未登録の社員は会社宛になります。
  - ② 会社に紐づく花屋のメニューを選択できるようになっています。デフォルトでは一番安価なメニューが設定されています。
  - ③ イレギュラーなケースを想定して、特定の社員に対して、お花を贈らないようにすることができます。贈らないと設定した社員への情報は花屋への注文メールには記載されないようになっています。(退職したが、社員情報で削除をし忘れたケースなどを想定しています。)
- ※ 次回の注文データは花屋への注文が完了後に自動的に生成されます。
### 会社代表者へのリマインド
  - 毎月、1日に会社代表者に注文内容の更新し忘れを防止するためにリマインドメール送信します。
### 社員情報の閲覧、追加、編集、削除、検索
  - ホーム画面で上記の5つの操作が可能となっています。

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

## 各種リンク
- [本番環境](https://one-step-gift-app-e4ebd1941fff.herokuapp.com/)
- [heroku](https://dashboard.heroku.com/apps/one-step-gift-app)
- [Google Drive](https://drive.google.com/drive/u/0/folders/13ehpUNUTKgzfgBoOInEibuvr4ExCjoku)
- [UIデザイン](https://www.figma.com/file/8hCVnFM22M6ljUX7u8HobU/ohana?type=design&node-id=0-1&mode=design)
- [お名前メール(メールサーバー)](https://cp.onamae.ne.jp/)
- [お名前メール(webメール)](https://webmail12.onamae.ne.jp/?_task=mail&_mbox=INBOX)
