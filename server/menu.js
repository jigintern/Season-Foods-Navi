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

const Shaping_recipe = (origin_recipe) => {
	const date = new Date();
	const now_month = date.getMonth()+1;
	const foods = origin_recipe.recipeMaterial
	const shaped_foods = []

	foods.map( async function (food) {
		let shaped_food = {}

		try {
			// 食材IDの取得
			let db_res = await pool.query('SELECT * FROM `foods` WHERE `name` LIKE ?', ['%' + food + '%'])
			if (db_res.length == 0) console.log(food + ' is not found in the DB')
			if (db_res.length != 0) {
				const food_id = db_res[0].id
				// 旬か否かの判定
				const months =  db_res[0].months.split(',');
				const syun = months.some(item => item  === String(now_month))

				shaped_food = {
					id		: db_res[0].id,
					name	: db_res[0].name,
					syun	: syun,
					pref_id	: db_res[0].pref_id,
				}
			} else {
				shaped_food = {
					id		: 0,
					name	: food,
					syun	: null,
					pref_id	: 0,
				}
			}
			shaped_foods.push(shaped_food);
		} catch (err) {
			throw new Error(err)
		}
	});

	const shaped_recipe = {
		id		: origin_recipe.recipeId,
		name	: origin_recipe.recipeTitle,
		picture	: origin_recipe.mediumImageUrl,
		foods	: shaped_foods,
		cal		: null,
		pref_id	: 0,
		prefecture	: 'ALL',
		howto	: origin_recipe.recipeDescription + '\n' + origin_recipe.recipeUrl,
		post	: false,
		cost	: origin_recipe.recipeCost,
		time	: origin_recipe.recipeIndication,
	};

	return shaped_recipe
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

	// // 緯度・経度が両方揃っている時
	// if (urlInfo.query.lat && urlInfo.query.long) {
	// 	let pos = {}
	// 	let pos_id
	// 	let db_res // DBの結果用
	// 	pos.lat = urlInfo.query.lat
	// 	pos.long = urlInfo.query.long

	// 	const prefecture = await pref.GetPrefecture(pos.long, pos.lat);

	// 	// pool.query()はpool.getConnection() + connection.query() + connection.release()のショートカット
	// 	try {
	// 		// 県IDの取得
	// 		db_res = await pool.query('SELECT * FROM `prefecture` WHERE `name` = ?', [prefecture])
	// 		pos_id = db_res[0].id
	// 		// 郷土料理の検索
	// 		db_res = await pool.query('SELECT * FROM `recipes` WHERE `pref_id` = ?', [pos_id])
	// 		result.push(db_res)
	// 		// 地元食材を検索
	// 		food_name = await pool.query('SELECT * FROM `foods` WHERE `pref_id` = ?', [pos_id])
	// 		food_name.map()


	// 		// 地元食材を使ったレシピを検索
	// 		// 1. 地元食材を検索
	// 		// 2. 該当する食材について、もとの食材でレシピAPIを叩く
	// 		// 3. その結果を出力に混ぜる
	// 	} catch (err) {
	// 		throw new Error(err)
	// 	}

	// }

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
							result.push(Shaping_recipe(recipes.result[recipe]));
							// result.push(recipes.result[recipe]);
						}
					} catch (err) {
						console.error(err);
					}
				}
			}
			// console.log(result) 
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