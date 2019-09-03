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
        const response = []
        const foods = [fruits, seafoods, vegetables]
        /*
        ~ foodsの中身 ~
        foods = [
            [
                [
                    {
                        name: みかん,
                        HighPrice: 200,
                        MediumPeice: 190,
                        place: 福井県
                    }...×n個
                ],
                [] ...×8個
            ],
            [],
            []
        ]
        */
        for (let i = 0; i < foods.length; i++) {
            foods[i].forEach((element, idx_1) => {
                element.forEach((food, idx_2) => {
                    if (food.name === name) {
                        console.log(food)
                    }
                })
            })
        }
        const dummy_response = [{
                place: 'アメリカ合衆国',
                HighPrice: [
                    // ない月は '-' にする
                    200, 200, 233, '-', '-', 259, 233, 250
                ],
                MediumPrice: [
                    190, 190, 190, '-', '-', 190, 190, 200
                ]
            },
            {
                place: '福井県',
                HighPrice: [
                    // ない月は '-' にする
                    200, 200, 233, '-', '-', 259, 233, 250
                ],
                MediumPrice: [
                    190, 190, 190, '-', '-', 190, 190, 200
                ]
            }
        ]
        resolve(dummy_response)
        // const response = []
        // const highPrice_1 = []
        // const highPrice_2 = []
        // const mediumPrice_1 = []
        // const mediumPrice_2 = []
        // const object_1 = {}
        // const object_2 = {}
        // let cnt = 0

        // for (let i = 0; i < fruits.length; i++) {
        //     fruits[i].filter((item, idx) => {
        //         if (item.name === name) {
        //             if (cnt % 2 === 0) {
        //                 object_1['place'] = item.place
        //                 highPrice_1.push(item.HighPrice)
        //                 mediumPrice_1.push(item.MediumPrice)
        //             } else {
        //                 object_2['place'] = item.place
        //                 highPrice_2.push(item.HighPrice)
        //                 mediumPrice_2.push(item.MediumPrice)
        //             }
        //             console.log('あった!! 月: ' + i + ' : ' + cnt)
        //             cnt++
        //         } else if (i === fruits.length - 1) {

        //         }
        //     })
        // }
        // object_1['HighPrice'] = highPrice_1
        // object_2['HighPrice'] = highPrice_2
        // object_1['MediumPrice'] = mediumPrice_1
        // object_2['MediumPrice'] = mediumPrice_2
        // response.push(object_1)
        // response.push(object_2)
        // resolve(response)
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
/**
 * 値段データがないときは　"-"を入れるようにする
 */