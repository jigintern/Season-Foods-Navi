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
        console.log(foods)
        // foods[i] = {
        //    name: みかん,
        //    HighPrice: 200,
        //    MediumPeice: 190,
        //    place: 福井県,
        //    month: 0
        // }...×n個

        const response = foods.reduce((map, food) => {
            if (!food.place in map) {
                map[food.place] = {
                    HighPrice: ['-', '-', '-', '-', '-', '-', '-', '-'],
                    MediumPrice: ['-', '-', '-', '-', '-', '-', '-', '-']
                }
            }
            // map[food.place].HighPrice[food.month] = food.HighPrice
            // map[food.place].MediumPrice[food.month] = food.MediumPrice
            return map
        })
        console.log(response)
        /*
        ~ foodsの中身 ~
        console.log(foods)
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
        // const places = []
        // for (let i = 0; i < foods.length; i++) {
        //     foods[i].forEach((element, idx_1) => {
        //         element.forEach((food, idx_2) => {
        //             if (food.name === name) {
        //                 if (places.indexOf(food.place) == -1) {
        //                     places.push(food.place)
        //                 } else {

        //                 }
        //             }
        //         })
        //     })
        // }
        // console.log(places)
        // const object = {}
        // const highprice = []
        // const mediumprice = []

        // let placeNum = 0
        // let flag = 0
        // let initplace = "null"
        // for (let i = 0; i < foods.length; i++) {
        //     foods[i].forEach((element, idx_1) => {
        //         element.forEach((food, idx_2) => {
        //             console.log(placeNum)
        //             if (food.name === name) {
        //                 console.log(initplace)

        //                 if (placeNum === 0 && initplace === "null") {
        //                     initplace = food.place
        //                 }
        //                 if (placeNum != 0 && food.place === initplace) {
        //                     console.log(placeNum + "found");
        //                     placeNum = 0;
        //                     flag = 1
        //                 }

        //                 //console.log(food)
        //                 object['place'] = food.place
        //                 if (flag) {
        //                     highprice[placeNum].push(food.HighPrice)
        //                     mediumprice[placeNum].push(food.MediumPrice)
        //                 } else {
        //                     const highprice_0 = food.HighPrice
        //                     const midiumprice_0 = food.MidiumPrice
        //                     highprice.push(highprice_0)
        //                     mediumprice.push(midiumprice_0)
        //                 }
        //                 placeNum++
        //             }
        //         })
        //     })
        // }
        // object['HighPrice'] = highprice
        // object['MediumPrice'] = mediumprice
        // response.push(object);
        resolve('test');

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
        // resolve(dummy_response)
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