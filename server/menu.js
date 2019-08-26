'use strict';
require('dotenv').config();
const request = require('request');

const RECIPE_CATEGORY_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426";
const RECIPE_RANKING_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426";

function GetRecipe()
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

	const get_categories = function() {
		categories = GetCategoryList();
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
		// food_name.map((name) => {
		// 	const match_category = Object.keys(categories).foreach((category_type) => {
		// 		category_type.filter(function(item, index){
		// 			if ((item.categoryName).indexOf(name) >= 0) return true;
		// 		});
		// 	});

		// 	console.log(match_category);
		// });
	}

	const get_recipe_ranking = function() {
		//特定のカテゴリのランキングを取得して出力
	}

	const processAll = async function() {
		await get_categories()
		await extraction_search()
		await get_recipe_ranking()
	}

	processAll()
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