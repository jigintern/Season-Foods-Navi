'use strict';
require('dotenv').config();
const request = require('request');

const RECIPE_CATEGORY_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426";
const RECIPE_RANKING_URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426";

function GetCategoryList(callback)
{
	const category_list =  new Promise((resolve, reject) => {
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
				callback(res)
				resolve('success : GetCategoryList()')
			}
		})
	});

	category_list.then((res) => {
		console.log(res);
	});
}

module.exports = {
    GetCategoryList: GetCategoryList
}