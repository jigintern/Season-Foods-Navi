import mysql from 'mysql'

const searchFood = (id) => {
    const connection = mysql.createPool({
        host: 'mariadb',
        user: 'SeasonFoodsNavi',
        password: 'SeasonFoodsNavi',
        database: 'season_foods_navi'
    })
    return new Promise((resolve, reject) => {
        connection.query(`SELECT * FROM foods WHERE id=${id}`, function (err, row, field) {
            if (err) {
                throw err
            }
            resolve(row[0])
        })
    })
}
const all = async (id) => {
    // console.log('1: all')
    const result = await searchFood(id)
    return result
}

module.exports = {
    getFood: all
}