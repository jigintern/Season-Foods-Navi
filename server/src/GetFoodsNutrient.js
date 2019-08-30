process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const httpClient = require('cheerio-httpcli');

async function GetFoodsNutrientJSON(url){
    const GET_URL = url //'https://fooddb.mext.go.jp/details/details.pl?ITEM_NO=12_12004_7';
    // HTMLデータを取得
    const result = await httpClient.fetch(GET_URL);
    //console.log(GET_URL);
    
    const $ = result.$;
    const logList = [];
    const OO = {};
    let Title = "";
    const GetNameList = ["エネルギー","たんぱく質","脂質","炭水化物",
                "ナトリウム","カリウム","カルシウム","マグネシウム","コレステロール","食塩相当量"];
        //const GetName = food;
        // HTML内の表の行データを取得して変換してリストに入れる
    /**
     * 
        */
    Title = $('span.foodfullname').text();
        //Title = $(this).find(".foodfullname").text();
        //console.log(Title)
    //});


    $('tr', '#nut').filter(function () { return $(this).attr('class') != 'pr_tit'; }).each(function () {
        const nObject = {};
        const Name = $(this).find(".no_under").text();
        if(GetNameList.indexOf(Name) >= 0){
        //if(GetName == 0){
            nObject["name"] = Name;
            nObject["value"] = $(this).find(".num").text();
            nObject["unit"] = $(this).find(".pr_unit").text();
            logList.push(nObject);
        } 
    });
    OO["food"] = Title; 
    OO["info"] = logList;

    //console.log(JSON.stringify(logList,undefined,1)); 
    //return JSON.stringify(logList,undefined,1) 
    return OO;
}
    
module.exports = {
    GetFoodsNutrientJSON: GetFoodsNutrientJSON
}
