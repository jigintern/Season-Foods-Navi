'use strict';

var url = require('url');
var menu = require('./menu');
import {
    searchFoodName
} from './getPrice'
import {
    getFood
} from './getFood'
import {
    getNutritional
} from './getNutritional'
var configRoutes;
var urlInfo;

configRoutes = function (app, server) {
    app.get('/api/', function (request, response) {
        response.sendFile(__dirname + '/public/index.html');
    });

    //共通処理
    app.all('/api/*', function (request, response, next) {
        let hrstart = process.hrtime();
        response.on('finish', function() {
            let hrtime = process.hrtime(hrstart);
            console.info('Execution time: %ds %dms', hrtime[0], hrtime[1] / 1000000);
        });
        // クエリー文字列を含めてurl情報を取得（trueオプションでクエリ文字列も取得）
        urlInfo = url.parse(request.url, true);
        // jsonでレスポンス（外部の人もアクセスできるようにAccess-Control-Allow-Originを設定）
        response.contentType('json');
        response.header('Access-Control-Allow-Origin', '*');
        // リクエストの表示
        console.log(`Access : [${request.ip}] [${request.originalUrl}] [${request.get('User-Agent')}]`)
        next();
    });

    app.get('/api/v1/menu/', async function (request, response) {
        const result = await menu.GetRecipe(urlInfo);
        response.send(result);

        // ダミーデータの返却
        // const data = require('./public/DummyDataList.json');
        // response.send(data);
    });

    app.get('/api/v1/menu/category_list/', async function (request, response) {
        const result = await menu.GetCategoryList();
        console.log(result);
        response.send(result);
    });

    app.get('/api/v1/menu/ranking/:id', async function (request, response) {
        const id = await request.params.id;
        const result = menu.GetRecipeRanking(id);
        response.send(result);
    });


    app.get('/api/v1/food/:id', async function (request, response) {
        const id = await request.params.id
        if (!id.match(/\d+(?:\.\d+)?/)) {
            response.send('あほ しね')
            return
        }
        const [
            result,
            food,
            nutritional
        ] = await Promise.all([searchFoodName(id), getFood(id), getNutritional(id)])
        const response_object = {}
        response_object['food_info'] = {
            id: food.id,
            name: food.name,
            base_food: food.base_food,
            picture: food.picture,
            months: food.months,
            pref_id: food.pref_id,
            post: food.post
        }
        response_object['prices'] = result
        if (nutritional === '') {
            response_object['nutritional'] = null
        } else {
            response_object['nutritional'] = nutritional
        }
        response.send(response_object)
    })
}

module.exports = {
    configRoutes: configRoutes
};