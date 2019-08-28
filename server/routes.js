'use strict';

var url = require('url');
var menu = require('./menu');
var configRoutes;
var urlInfo;

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

    app.get('/api/v1/menu/', async function(request, response) {
        const result = await menu.GetRecipe();
        response.send(result);

        // ダミーデータの返却
        // const data = require('./public/DummyDataList.json');
        // response.send(data);
    });

    app.get('/api/v1/menu/category_list/', async function(request, response) {
        const result = await menu.GetCategoryList();
        console.log(result);
        response.send(result);
    });

    app.get('/api/v1/menu/ranking/:id', async function(request, response) {
        const id = await request.params.id;
        const result = menu.GetRecipeRanking(id);
        response.send(result);
    });
}

module.exports = {configRoutes: configRoutes};