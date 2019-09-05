import mysql from 'mysql'
const searchFoodPrice = (name) => {
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
        const foods2 = [
            ...fruits.map((month, m) => {
                return month
                    .filter(f => f.name === name)
                    .map(f => {
                        f.month = m
                        return f
                    })
            }),
            ...seafoods.map((month, m) => {
                return month.filter(s => s.name === name)
                    .map(f => {
                        f.month = m
                        return f
                    })
            }),
            ...vegetables.map((month, m) => {
                return month.filter(v => v.name === name)
                    .map(f => {
                        f.month = m
                        return f
                    })
            })
        ]
        const foods = []
        foods2.forEach(f => {
            f.forEach(ff => {
                foods.push(ff)
            })
        })
        const response = foods.reduce((map, food) => {
            if (!(food.place in map)) {
                map[food.place] = {
                    HighPrice: ['-', '-', '-', '-', '-', '-', '-', '-'],
                    MediumPrice: ['-', '-', '-', '-', '-', '-', '-', '-']
                }
            }
            map[food.place].HighPrice[food.month] = food.HighPrice
            map[food.place].MediumPrice[food.month] = food.MediumPrice
            return map
        }, {})
        resolve(response)
    })
}
const all = async (id) => {
    const name = await searchPrefecture(id)
    const prices = await searchFoodPrice(name)
    return prices
}
const searchPrefecture = (id) => {
    const connection = mysql.createPool({
        host: 'mariadb',
        user: 'SeasonFoodsNavi',
        password: 'SeasonFoodsNavi',
        database: 'season_foods_navi'
    })
    return new Promise((resolve, reject) => {
        connection.query(`SELECT * FROM foods WHERE id=?`, [id], function (err, row, field) {
            if (err) {
                throw err
            }
            if (row.length == 0)
                resolve('')
            else
                resolve(row[0].name)
        })
    })
}
module.exports = {
    searchFoodName: all
}