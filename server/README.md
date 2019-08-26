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

```
git clone git@github.com:jigintern/Season-Foods-Navi.git
cd Season-Foods-Navi/server

docker-compose build
docker-compose up
```

http://localhost:3000/ が表示されれば、動作しています。

## コンテナログイン方法
```bash
$ docker exec -it server_app_1 bash
```