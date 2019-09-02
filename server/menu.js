'use strict';
require('dotenv').config();
const request = require('request');
const mysql = require('mysql');
const util = require('util');
const pool  = mysql.createPool({
	connectionLimit : 10,
	host            : 'mariadb',
	user            : 'SeasonFoodsNavi',
	password        : 'SeasonFoodsNavi',
	database        : 'season_foods_navi',
});
pool.query = util.promisify(pool.query);
var pref = require('./GetPrefecture');

const RECIPE_CATEGORY_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426";
const RECIPE_RANKING_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426";

// reference: https://laboradian.com/js-wait/
const wait = (sec) => {
	return new Promise((resolve, reject) => {
	  setTimeout(resolve, sec*1000);
	});
};

// reference: https://github.com/30-seconds/30-seconds-of-code#shuffle
const shuffle = ([...arr]) => {
	let m = arr.length;
	while (m) {
		const i = Math.floor(Math.random() * m--);
		[arr[m], arr[i]] = [arr[i], arr[m]];
	}
	return arr;
};

async function GetRecipe(urlInfo)
{
	/*
	1. 楽天レシピAPIからカテゴリ一覧を取得
	2. 与えられた食材名がカテゴリに存在するのか確認
	3. カテゴリに存在すれば、そのカテゴリのうち、上位2件を取得して返す
	*/
	const season_foods = require('./public/DummySeasonFoods.json');
	const date = new Date();
	const month = date.getMonth()+1;
	let categories = [];
	let food_name = [];
	let match_categories = [];
	let result = [];
	let res_JSON = {};

	// 緯度・経度が両方揃っている時
	if (urlInfo.query.lat && urlInfo.query.long) {
		let pos = {}
		let pos_id
		pos.lat = urlInfo.query.lat
		pos.long = urlInfo.query.long

		const prefecture = await pref.GetPrefecture(pos.long, pos.lat);

		// pool.query()はpool.getConnection() + connection.query() + connection.release()のショートカット
		try {
			let results = await pool.query('SELECT * FROM `prefecture` WHERE `name` = ?', [prefecture])
			pos_id = results[0].id
			pool.end(); // mysqlのコネクションのプロセスを終了させる。（2018-11-07追記）
		} catch (err) {
			throw new Error(err)
		}

		console.log(pos_id)

	// 	pool.getConnection(function(err, connection){
	// 		if(err) { // throwすると、コネクションに1回でもミスしたら終了してしまう
	// 			console.log(err)
	// 			return
	// 		}
	// 		connection.query( 'SELECT * FROM `prefecture` WHERE `name` = ?', [prefecture], function(err, rows, fields){
	// 			if(err) throw err;

	// 			console.log(rows)
	// 			console.log(rows[0])
	// 			pos_id = rows[0].id

	// 			connection.release();
	// 		});

	// 		console.log(pos_id)
	// 	});
	}

	const response = new Promise((resolve, reject) => {
		const get_categories = async function() {
			categories = await GetCategoryList();
		}
	
		const extraction_search = function() {
			// 旬の食材名を抽出
			season_foods.seasonFoods.map((season_food) => {
				const index = season_food.season.findIndex(item => item === String(month));
				if (index !== -1) {
					food_name.push(season_food.name);
				}
			});
	
			// 旬の食材と合致するカテゴリを抽出
			food_name.map((name) => {
				for (const category_type in categories.result) {
					const match_category = categories.result[category_type].filter(function(item, index){
						if ((item.categoryName).indexOf(name) >= 0) return true;
					});
					if (match_category.length > 0)
						match_categories.push(match_category)
				}
			});
		}
	
		const get_recipe_ranking = async function() {
			//特定のカテゴリのランキングを取得して出力
			for (const match_category in match_categories) {
				for (const single in match_categories[match_category]) {
					try {
						await wait(1); // API制限の回避
	
						const category_id = match_categories[match_category][single].categoryUrl.match(/^https:\/\/recipe.rakuten.co.jp\/category\/(.*)\//)[1];
						const recipes = await GetRecipeRanking(category_id);
						for (const recipe in recipes.result) {
							result.push(recipes.result[recipe]);
						}
					} catch (err) {
						console.error(err);
					}
				}
			}
			const result_shuffle = shuffle(result) // 同じ食材を使ったレシピが集まるのを回避
			res_JSON = JSON.stringify({result: result_shuffle})
			// res_JSON[result.all] = result.length;
		}
	
		const processAll = async function() {
			await get_categories()
			await extraction_search()
			await get_recipe_ranking()
			resolve(res_JSON)
		}

		processAll()
	});

	return response
}

async function GetCategoryList()
{
	const category_list = await new Promise((resolve, reject) => {
		request.get({
			url: RECIPE_CATEGORY_URL,
			headers: {'Content-type': 'application/json'},
			qs: {
				applicationId: process.env.APPLICATION_ID,
				format: "json",
				formatVersion: "2",
			},
			json: true
		}, (err, req, res) => {
			if (err) {
				reject(err)
			} else {
				resolve(res)
			}
		})
	});

	return category_list
}

async function GetRecipeRanking(id)
{
	const resipe_ranking = await new Promise((resolve, reject) => {
		request.get({
			url: RECIPE_RANKING_URL,
			headers: {'Content-type': 'application/json'},
			qs: {
				applicationId: process.env.APPLICATION_ID,
				format: "json",
				formatVersion: "2",
				categoryId: id,
			},
			json: true
		}, (err, req, res) => {
			if (err) {
				reject(err)
			} else {
				resolve(res)
			}
		})
	});

	return resipe_ranking
}

module.exports = {
	GetRecipe: GetRecipe,
	GetCategoryList: GetCategoryList,
	GetRecipeRanking: GetRecipeRanking,
}