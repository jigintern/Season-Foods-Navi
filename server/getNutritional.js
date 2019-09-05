import mysql from 'mysql'
const nutritionals = require('./public/AllFoodNutritionalList.json')

const searchFoodName = (id) => {
    const connection = mysql.createPool({
        host: 'mariadb',
        user: 'SeasonFoodsNavi',
        password: 'SeasonFoodsNavi',
        database: 'season_foods_navi'
    })
    return new Promise((resolve, rejects) => {
        connection.query(`SELECT name FROM foods WHERE id=${id}`, function (err, row, field) {
            if (err) {
                throw err
            }
            resolve(row[0].name)
        })
    })
}

const searchNutritional = (food_name) => {
    return new Promise((resolve, rejects) => {
        nutritionals.nutritionals.forEach(element => {
            if (element.food.indexOf(food_name) > -1) {
                resolve(element)
            }
        });
        rejects('一致しませんでした')
    })
}
const all = async (id) => {
    const food_name = await searchFoodName(id)
    const nutritional = await searchNutritional(food_name).catch(() => '')
    return nutritional
}

module.exports = {
    getNutritional: all
}