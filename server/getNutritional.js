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
            // console.log(element.food)
            if (element.food.indexOf(food_name) > -1) {
                console.log(element.food)
                resolve(element)
            }
        });
        rejects('一致しませんでした')
        // console.log(nutritionals.nutritionals.length)
        // resolve('Nutritionals!!')
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