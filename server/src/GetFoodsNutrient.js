process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const httpClient = require('cheerio-httpcli');
const _ = require('lodash');
const moment = require('moment');

async function main() {
    const GET_URL = 'https://fooddb.mext.go.jp/details/details.pl?ITEM_NO=12_12004_7';
          // HTMLデータを取得
        const result = await httpClient.fetch(GET_URL);

        const $ = result.$;
        const logList = [];


            // HTML内の表の行データを取得して変換してリストに入れる
        $('tr', '#nut').filter(function () { return $(this).attr('class') != 'pr_tit'; }).each(function () {
            const nObject = {};
            nObject["name"] = $(this).find(".no_under").text();
            nObject["value"] = $(this).find(".num").text();
            nObject["unit"] = $(this).find(".pr_unit").text();
            logList.push(nObject);
        });
        console.log(JSON.stringify(logList,undefined,1));
        

}

main();

