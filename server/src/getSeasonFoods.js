const client = require('cheerio-httpcli')
const season_foods = []
client.fetch('https://k52.org/syokuzai/', {}, function (err, $, res, body) {
    const foods = ['vegetable', 'fruit', 'fish', 'marine', 'others']
    for(const food of foods) {
        $(`#main .calendar.${food} tr`).each(function(idx, element) {
            if(idx == 0) return true
            const food_object = {}
            food_object["name"] = $(this).find(".name").text()
            food_object["season"] = []
            $(this).find(".month .syun").each(function(idx, elements) {
                food_object.season.push($(this).text())
            })
            season_foods.push(food_object)
        })
    }
    //console.log(season_foods)
    console.log(JSON.stringify(season_foods,undefined,1));
});
