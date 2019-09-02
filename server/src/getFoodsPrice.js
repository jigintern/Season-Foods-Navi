const client = require('cheerio-httpcli')
const foodPrices = [];
client.fetch('http://www.fukui-market.jp/marketinfo/condition/', {}, function (err, $, res, body) {
    const category = ['yasai', 'kajitsu', 'suisan']
    for(const food of category) {
        let prevName = "";
        $(`#contents #${food} table tr`).each(function(idx, element) {
            const items = ['name', 'place', 'price']
            const food_object = {};
            for(const t of items) {
                if($(this).has('.name').length === 0) {
                    food_object[`name`] = prevName;
                }
                $(this).find(`.${t}`).each(function(idx, element) {
                    if(t === 'price') {
                        if(idx === 0) {
                            food_object["高値"] = $(this).text().replace(/\t|\n|\r/g, "");
                        } else {
                            food_object["中値"] = $(this).text().replace(/\t|\n|\r/g, "");
                        }
                    } else if(t === 'name') {

                        food_object[`name`] = $(this).text().replace(/\t|\n|\r/g, "");
                        prevName = food_object['name'];
                    } else {
                        food_object["place"] = $(this).text().replace(/\t|\n|\r/g, "");
                    }
                })
            }
            foodPrices.push(food_object);
       })
    }
    console.log(JSON.stringify(foodPrices,undefined,1))
});
