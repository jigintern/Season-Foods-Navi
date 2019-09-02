const client = require('cheerio-httpcli')
const fs = require('fs')
client.fetch('http://www.fukui-market.jp/marketinfo/condition/search.php', {}, function (err, $, res, body) {
    const form = $('form[method=post]')
    for(let month = 1; month <= 8; month++) {
        if(month < 10) month = '0'+month
        for(let kind = 1; kind <= 3; kind++) {
            let day = 1
            let result;
            while(1) {
                result = submitForm(form, 2019, month, day, kind)
                if(result.$('#past time').text() !== "") break; 
                day++
            }
            searchFoods(result, $, month, kind)
        }
    }
});

const submitForm = (form, y, m, d, k) => {
    form.field({
        search_date_y: y,
        search_date_m: m,
        search_date_d: d,
        search_kind: k,
    })
    const result = form.submitSync()
    return result
}

const searchFoods = (result, $, month, kind) => {
    const category = ['vegetables', 'fruit', 'seafood']
    const food_prices = []
    let prev_name = ""
    result.$("#contents table tr").each(function(idx, element) {
        if(idx === 0) return true
        const food_object = {}
        if(!$(this).has('.name').length) food_object["名前"] = prev_name
        else {
            prev_name = $(this).find(".name").text().replace(/\t|\n|\r/g, "")
            food_object["名前"] = $(this).find(".name").text().replace(/\t|\n|\r/g, "")
        }
        $(this).find(".price").each(function(idx, element) {
            if(!idx) {
                food_object["高値"] = $(this).text().replace(/\t|\n|\r/g, "")
            } else {
                food_object["中値"] = $(this).text().replace(/\t|\n|\r/g, "")
            }
        })
        food_object["場所"] = $(this).find(".place").text().replace(/\t|\n|\r/g, "")
        food_prices.push(food_object)
    })
    fs.writeFile(`price_${month}_${category[kind-1]}.json`, JSON.stringify(food_prices,undefined,1), function(err, result) {
        if(err) console.log('error!!' , err);
        console.log(`${month}_${category[kind-1]}の書き込みが完了しました`)
    })
}

/**
 * 月１で取得する 2019_1月 ~ 8月まで
 * n月1日がなければn月2日 ... って感じで取得
 * 各カテゴリごと
 */