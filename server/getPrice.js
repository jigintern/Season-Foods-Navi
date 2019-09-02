import mysql from 'mysql'
const searchFoodPrice = (name) => {
    // console.log('This is searchFoodPrice ' + name)
    return new Promise((resolve, reject) => {
        const fruits = []
        const seafoods = []
        const vegetables = []
        const getAllFoodsPrice = () => {
            const pad = (n) => n < 10 ? '0' + n : n
            for (let i = 1; i <= 8; i++) {
                const month = pad(i)
                fruits.push(require(`./public/data/price_${month}_fruit.json`))
                seafoods.push(require(`./public/data/price_${month}_seafood.json`))
                vegetables.push(require(`./public/data/price_${month}_vegetables.json`))
            }
        }
        getAllFoodsPrice()
        const response = []
        const highPrice_1 = []
        const highPrice_2 = []
        const mediumPrice_1 = []
        const mediumPrice_2 = []
        const object_1 = {}
        const object_2 = {}
        let cnt = 0
        for (let i = 0; i < fruits.length; i++) {
            fruits[i].filter((item, idx) => {
                if (item.name === name) {
                    if (cnt % 2 === 0) {
                        object_1['place'] = item.place
                        highPrice_1.push(item.HighPrice)
                        mediumPrice_1.push(item.MediumPrice)
                    } else {
                        object_2['place'] = item.place
                        highPrice_2.push(item.HighPrice)
                        mediumPrice_2.push(item.MediumPrice)
                    }
                    cnt++
                }
            })
        }
        object_1['HighPrice'] = highPrice_1
        object_2['HighPrice'] = highPrice_2
        object_1['MediumPrice'] = mediumPrice_1
        object_2['MediumPrice'] = mediumPrice_2
        response.push(object_1)
        response.push(object_2)
        resolve(response)
    })
}
const all = async (id) => {
    const name = await searchPrefecture(id)
    // console.log('Prefecture が帰ってきたよ' + name)
    const prices = await searchFoodPrice(name)
    // console.log('Priceが帰ってきたよ' + prices)
    return prices
}
const searchPrefecture = (id) => {
    // console.log('This is searchPrefecture ' + id)
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
            resolve(row[0].name)
        })
    })
}
module.exports = {
    searchFoodName: all
}