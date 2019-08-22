'use strict';

var url = require('url');
var configRoutes;

configRoutes = function(app, server) {
    app.get('/', function(request, response) {
        response.redirect('/index.html');
    });

    //共通処理
    app.all('/api/*', function(request, response, next){
        // クエリー文字列を含めてurl情報を取得（trueオプションでクエリ文字列も取得）
        urlInfo = url.parse(request.url, true);
        // jsonでレスポンス（外部の人もアクセスできるようにAccess-Control-Allow-Originを設定）
        response.contentType('json');
        response.header('Access-Control-Allow-Origin', '*');
        next();
    });
}

module.exports = {configRoutes: configRoutes};