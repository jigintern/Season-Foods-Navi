旬食ナビ | サーバ
====

旬食ナビのサーバです。

## 開発環境
* Node.js
* Express

## 実行方法
事前に以下のコマンドをインストールしてください。

* Git
* Docker
* docker-compose

その後、以下の操作により、実行できます。  
`docker-compose`実行時にエラーが表示される場合は、`sudo`をつけての実行を試してください。
```bash
$ git clone git@github.com:jigintern/Season-Foods-Navi.git
$ cd Season-Foods-Navi/server

$ docker-compose build
$ docker-compose up -d
```

http://localhost:3000/ が表示されれば、動作しています。

コンテナ終了時は、以下のコマンドを実行してください。
```bash
$ docker-compose down
```

## コンテナログイン方法
```bash
$ docker exec -it server_app_1 /bin/bash
$ docker exec -it server_mariadb_1 /bin/bash
```

## MariaDBログイン方法
```bash
$ mysql -u SeasonFoodsNavi -p
$ password: SeasonFoodsNavi
```